Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4EBCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHd-0006ID-3u; Wed, 10 Jun 2026 17:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHZ-0005rn-VV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHX-0007AB-S5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3GoQlNenHLrvRUS53w/q7NzOu6/wJCe23EcXIPNd4Q=;
 b=R6zag3BqfZh25MICwjVqbhwHnDZkCkvSZaAxaHOGCUeiWJvqF7pncllp87UXPGbWycuE6p
 5KV0mVXnK+W4inW/sY7r9Bzj+wuayuplAQckR+AY/dGi92CZx83prIbmJjmxnv1QEjgO9O
 RATt2DsXvgAb2/VkFfOZs0AMq7NI11c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-2d2HCUn_MwaW0VdSHIfiUg-1; Wed,
 10 Jun 2026 17:16:12 -0400
X-MC-Unique: 2d2HCUn_MwaW0VdSHIfiUg-1
X-Mimecast-MFC-AGG-ID: 2d2HCUn_MwaW0VdSHIfiUg_1781126170
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F35718E6A65; Wed, 10 Jun 2026 21:16:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EB371800347; Wed, 10 Jun 2026 21:16:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 26/35] monitor: protect qemu_chr_fe_accept_input
 with monitor lock
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-27-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-27-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600386.209622.1352724016087984956.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=588;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Yt2n5IZ1eRplCMgbvUtBvyz7E8JlgUhvKLA+WAfhJiA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOEXEItuR4H2m7SuDVxzwttV6/4MTqxuVfaK
 q7hDstXO7WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThAAKCRDa6OEJdZac
 5UC3D/9kK5w+QyIsXat+PmJbnyQKrT+uetB1rndlDqW2tv5vsVhCaI3XsTibQnUbXUMmT5QxZqV
 5goUeTErNDzGSlRIJy7FWccA/+M26pA4s1KkONR9T32IOB/rzsrQ1/L31iZQBggLyXxkMBfBdhg
 kd5lcv8mdkPc1VbtRvA4RqpPB8FgN5/34WZp04Zp9s81lni/1fLW1TojaCfXnnWQylssM3jupsv
 zBp9P3gDXl+ZAEKZ3VckgvkvyrLnBWGRR1nKKEy7WQWpvUrMxq41J6+SdjXaNKCo8nlO4SUHTI7
 DZbvPVOOw5WF0mV1Q0hFpIbPxRF5xnwT2LBuT+yXlCkUlaGGzeuh5GtcUakr6lf05NNtOIRHe3N
 Aogh3Ap2CynTijjyd1dX13Hluxm9cwHwDyh1I3d83/nCIGUdDFmDHFKeeQ8aFNedzCCMJM1OmCx
 Lnupdo90KxSaWltZcHmwkz3/lF7wY/j5jbb9dsxVPFzDGyKx4y4elgRh3MHRy+TLcJcY/1F7nLo
 YfZ2WAYIFanBKqSFeQk+6teVWhyfi8H7xLMBw9A10i9PTVgKsua/lxQeAj3E6gVa44pBaR8Xem2
 P7jtRKfet2++QZasUmc8Gt9xBgXJcK4lDWXusZO+MkpFHLxwJbn+CLs7bdsTYtrOU0pCsGmEbNy
 JlK8ebYCJbqr9oQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 10 Jun 2026 13:34:06 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The monitor_accept_input API is called from a bottom half, and will
> invoke qemu_chr_fe_accept_input().
> 
> When a following patch introduces the ability to delete monitors, it
> will be neccesary to delete the bottom half. Protecting the call to
> qemu_chr_fe_accept_input with the monitor lock will allow for
> synchronization with the deletion process.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



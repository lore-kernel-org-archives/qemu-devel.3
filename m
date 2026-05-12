Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C34CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmur-00040X-6C; Tue, 12 May 2026 09:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMmuh-00040B-73
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMmuf-0003io-0J
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778591559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1A9AoxgKYz5Jy7lXPi0luUveiwaBWEClgIY2NKw414U=;
 b=XusBk8kAzDoolCdv9CyHUbHkjgHXcVTIHdp3rZNqjWJp7K0XtYRjUjOOcPq1RLjYscXVZ8
 qvumiLbzzguIQAtYjhSqSNbmp5HnjwC0/WV5VK/Sjzz+6rvAw1Ku2OswKFv4/NFE5t57Tz
 IkHS7HMCAcF5Exjk+5qCMdteF8m/EAw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-n8lkM7LLOjeeHqr2kDgqgg-1; Tue,
 12 May 2026 09:12:36 -0400
X-MC-Unique: n8lkM7LLOjeeHqr2kDgqgg-1
X-Mimecast-MFC-AGG-ID: n8lkM7LLOjeeHqr2kDgqgg_1778591555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C12E180061B; Tue, 12 May 2026 13:12:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF853180058F; Tue, 12 May 2026 13:12:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/10] qom: misc cleanups / fixes
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512122958.788097-1-berrange@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
Date: Tue, 12 May 2026 17:12:24 +0400
Message-Id: <177859154464.4059703.18141668565825390320.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=436;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uFKi4tYQUjx+gHo43AyRCcb4lIRQfoNPQTrbzoo6GaQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAyc6ZbnSsxSZfdlxW5edg1JrQtR6uUlcq185Z
 3YDeqX52c+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagMnOgAKCRDa6OEJdZac
 5bnfEACOX/hPaFLjlABQGffoIkW5J4/j9cBZIGfz8LIilML9B4bwIrPPWhBsC+ev1ZVpNgS/JVs
 uStN1D67AhdYQcrtCPb1DeBuueSkTgW5GkmGOGW7LhjUPyJy3k8+NU1OYY2SrAhplJI3PsvpSes
 //arNwxuPMGZKgIEH/xE+AqCUlKzGse3tvnGsvQVfewq447zV6k9PAMCYzoohCfhtAmdRVvBFCk
 rxTAZpHwomcxTGXlH51EPGaQFX8rzgVVGLo/gVbaEbMQc5N4cN9kbdCEr5+zsRTBVOGS1hRdpco
 wW2mK6UkJY75UOT9dkX4xA/24F+5+8TfBXDUlvf/SUxentAPzfbdmh9NtN8FqxwYw/tCsSABT3B
 fQlsMGXf+oRSc1wuXxm1zXUO2/3yCjdAcYCpGARY7vYdQfW23z+/tr+hbIVJ6YuzO/6W6/vI6qf
 UIke+wvaSVjgGs6xsgxXV6n45YhmNF6pNEJf5A42fpnu2aj0b/+uBfRZ3hcZRO0o2VhQ8rFtt46
 rNYP8VgfnpplPgT0JABBFGuoTBTvJn3LeBms+LL48ANULwYHXztQX/hzKE6Nnj1FOAL+S8nkusD
 uNGdsqgoQas4TWLNv7DpwF8Nzw1M82sHcvDAnGVgyc22/FjBmJGbrBHMzp3rBl5xXrivE2gHY0g
 lvMZXW+nwfozdVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 12 May 2026 13:29:48 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> qom: misc cleanups / fixes
> 
> The overall theme of this patch is to move some logic out of
> object_interfaces.c into object.c, since it is not tied to
> the user creatable interface.
> 
> Changed in v4:
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



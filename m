Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E90FC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Om0-0003nL-5U; Wed, 09 Sep 2026 16:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Olv-0003lj-Ki
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Olu-0006qF-4w
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788985193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZjPrOg/hnVs/BKFBYAQxkq5NJCxjkiZ3myc0AFRN00=;
 b=Za/hMckaWtSpLbH2bTm96YuCEevLz9b2chZUyDTSBJaugLcPP8ouPGL5YPCvZx40nwNpKu
 swNfP2B4uHMl7CCopYWAJqUqIvoVZfsZjcrdz37/AcLZyv1v/rwT8n7rS7ZOJTFijwPnFo
 NOeYxxSGhRFJdX/Hjq9Yfv2563kFrv4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-kEeJ0ZOEM2elzL0-lWpPtQ-1; Wed,
 09 Sep 2026 16:19:50 -0400
X-MC-Unique: kEeJ0ZOEM2elzL0-lWpPtQ-1
X-Mimecast-MFC-AGG-ID: kEeJ0ZOEM2elzL0-lWpPtQ_1788985189
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDD1F18005A2; Wed,  9 Sep 2026 20:19:48 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1794A19560AB; Wed,  9 Sep 2026 20:19:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 04/14] system: check security for accelerator types
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260909175656.1572689-5-berrange@redhat.com>
References: <20260909175656.1572689-1-berrange@redhat.com>
 <20260909175656.1572689-5-berrange@redhat.com>
Date: Thu, 10 Sep 2026 00:19:30 +0400
Message-Id: <178898517055.2613908.14482868961436708322.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=527;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FZ8AFznySCy1zZCShGO9ppy3Y1eqZEwwij9jGZA2+rg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqob9VY8gEufFoGkuXxc2jFxYC6fS9tW1pqGcmI
 lsJdr8RfKSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqG/VQAKCRDa6OEJdZac
 5TXSD/48Tfldn0TbAabCZC11x2p7F4uywJhjE8gVhGsOHpG0ZL8sFibbsUftDLl+lpoi4Az5EI5
 HrPgIVX9n4hfXAMYlhNId0ve5/sYDG6SJGylDxL3Nla/15UAetuDzeJmysE6g16GuKAKTIEqcgF
 xU96KlQ/6hVKPPK/z5ktQcJwc3JGx4J3v4UKY/K0ikn9vZ50Tm5Q0Y2qi/qq9e4icWHUgcvS8/U
 BGCPrPaQioTH+EF1er4Y+qDgTLUNhjsrD1DJcgFNIsMZlPXgttCjeOCX9/y/GYwnWsPHPrAmZ/0
 2sqP5nNtGZmsUdvrSc3sxe3ngUiPYBkQML+XzWyFXoFuUTfUuDS2yVg2RrIKU4fBLKFcCFxB/F2
 bmHWJBq6BfQnUS+GE1MpTARdG7LEapFSkaAE12zGPFW+KuiNvGs1nMq2cEPFz1OiqojmScA4spl
 m3RM43eBz2v3eUrbYfTbK7NkenNh8qXDefOahiATpuUt+myegCJ8Gugk4i1kpMP/0QCrda1CEyz
 uMf6fXia6584lx1y258/Q/46sGVgWPWy4xEZAVrz84j+oLksVTCvJAsoDFEM6uId6RFJbDyGWOF
 uJ/73hNitq7kWBFmnlRNkJa5tK7Xl4aa0gAoN9bSs5fZWz9uzveqGtrWY3+zGbYGZ2HerxheFV9
 3lKPo64TMr5Givg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 09 Sep 2026 18:56:46 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> This wires up the accelerator creation code to apply the compat policy
> security check. When multiple -accel options are given, normal fallback
> logic applies. IOW, if one is rejected by the security check, it will
> carry on to try the next accelerator until one passes the security
> check.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>



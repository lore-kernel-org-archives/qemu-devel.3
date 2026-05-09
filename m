Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E557CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9n-0000go-6k; Sat, 09 May 2026 01:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9m-0000ge-8i
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9k-0007I6-TP
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nNkszS3JD+hctSC8f4FoyRu8v9EIlOM/MNYQI7jR03Q=;
 b=BCXpY5MOLnnFIHDWSQQ50u7Qapu8T8RGhyR8LzhS6rlRNMh+9DUDA0dd64olEvxezpORKj
 iyMS0V6PLFVVmIoghoK+7Y9TwN5KGy8C7ElS3gO2YAxhCUb6zWaE4mgEQPAJe4nr7l2Mzn
 2Vs2y2rNGk8rQSAjkRTavx1oaFoMNwM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-oAzG_JpTNxC7uRCDuJEsuQ-1; Sat, 09 May 2026 01:23:14 -0400
X-MC-Unique: oAzG_JpTNxC7uRCDuJEsuQ-1
X-Mimecast-MFC-AGG-ID: oAzG_JpTNxC7uRCDuJEsuQ_1778304193
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48d144d3428so15090785e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304191; x=1778908991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNkszS3JD+hctSC8f4FoyRu8v9EIlOM/MNYQI7jR03Q=;
 b=ISet4cKQA078qZ7Tzw/ceI7B38msnhfINMbC9k54sIDSmRbUkAco4oQQPVPAHh2L3z
 N/k5dsKD62N8dMAK6EbIFhAA++X/wVlUSTwYGhzRM8EfgspV1fohXOWCtTkyT0wl7u2A
 XbiyxkaUkulYm+NUKYdok2eP1e80sWZqFwz4N1ib19Ek3T+VmS4YrxhkdV+o4tC5qcNG
 z3wcYMIrLWbw6P2nLWxKrJYpvmnFRnOPWFUVAZ/2K7sZbAfFHzKOpgtNvXgT3x6u2nDX
 eq3ja5jSpENsmEenyNhxGTe+zH5Sn2rmr/oJ00eEpFmAENnfeH0IOg+uRY5YWUhifnyE
 PBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304191; x=1778908991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNkszS3JD+hctSC8f4FoyRu8v9EIlOM/MNYQI7jR03Q=;
 b=ia7IXRKIP+EaZZj3CFUaANMb2Cp6p0fEt35AucrU4iwiCB4nuPAicfBS0gMgKmCGO/
 FjZoGFMZTxFzI7827rYqmtxgrVF1kOZ9tE51KfR2p/wjiA3Rg6DwONZC7YNR2W/7rvNG
 VeY57oXW0o7AIQoqic3HBxm73dGMWCDQ1svN7m1CvOiyGlJKldjWf8N1L9Ar/fqNLikc
 gtA5sxvgLNdnUB7WY/IZ/xgOdxdK3mjyoQHnDqT23rJewd3/gcG1+g70UkDcYYkotPG1
 IczYIxxDyzenVvdE4r3UCSxLhnca4GlJ/Ts4lCbuKHjO8229keVG5GNqG2gZU7hx41Yt
 pW2w==
X-Gm-Message-State: AOJu0YymuoHd/jvH5EfLdXfBo3Q76C2rEHbJ7vmKNsqP8tAlMxwVHPsh
 CpCmoJQUoTaAW9eDfm+tzBbk5lfnNUTPzu05wNrF7TJMVaASNxDR7NEfSigu79SG+Vlv3ZXuXCO
 IYholOeyYnlJUyqGXXcA4WBiya9wSVJgDvGZUvwGdp9uZYjqbBLm4zXWPzBFVIod1zYJzCx+Ig5
 I5Rxz1l63Siojh87L+QIuexPjMMY2lB0fjDZktzXdJ
X-Gm-Gg: Acq92OEWFlbq7yPKXvNIuipOXpuDZv/SwvVr0TQiJSzukzePu1YcmZEveDweDTx7Lis
 +A7Uc8sA7mwxdfGuesWkUNDYcJO6pGSx4Up2r02zYuXG3DNbpa2+KUE+T9BqrkFonj7FluajjjM
 Gt0uBMPUnaFdN3s/iIj3iT5HseYCfkwy0Pt+aORjlvgTcrA1moawgbGwRMZEHfcZ7Rmf91qRbQw
 oC9m6mVWaan5xPSi0qtSQOJKwpgod4DCS3sxjZumVU+BJGI45BP76n3JVvPcB/FDuotqUxgeAhM
 tuA0stbDqsy7C7WAgy16v104NMNUxCE5FHopV+5qOv3LhKIgVXTxMqUlTfz1HZOlYJ+SIh6bNM8
 eVBpkN3N/7RfYZ7ruSgMqchq8TDiY/P+IL68dFzvj7oy0YKvDesiglcXf/wX/2CiJSuzWvJH8eJ
 I1+vVfgQO2BgfaLC0qB3ux6VkGWPoS
X-Received: by 2002:a05:600d:e:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48e706d24e3mr13945805e9.24.1778304191259; 
 Fri, 08 May 2026 22:23:11 -0700 (PDT)
X-Received: by 2002:a05:600d:e:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48e706d24e3mr13945545e9.24.1778304190891; 
 Fri, 08 May 2026 22:23:10 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e7040a9a9sm38609605e9.9.2026.05.08.22.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/5] scsi: adjust error_prepend() formatting
Date: Sat,  9 May 2026 07:23:01 +0200
Message-ID: <20260509052304.2159829-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The error strings will be concatenated so add a separator to make the
combined error message easy to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260401171927.396672-2-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e629b1756b0..d0086d86d94 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -439,7 +439,7 @@ static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER: ");
         return false;
     }
     return true;
@@ -463,7 +463,7 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT: ");
         return false;
     }
     return true;
-- 
2.54.0



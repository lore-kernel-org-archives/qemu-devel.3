Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D1EC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pa5-00060f-EU; Wed, 16 Sep 2026 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa4-00060X-1k
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pa2-000351-IE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbDTV79hKw2WSZhcto0ou4JyiENGFfJ16eNkhC8Ca+Y=;
 b=eOiMej5NlM6djAC3zgs7jou8yN+IRW7nN1P3hYAVbRXYiyoDXpl5OSeOKs0/oHPlTX1Sug
 B0ZK/oBoLnBTsQUW/k9DBpKy1nT9qE4anOC3aMFI9fTMf1f5r5t3a+zg4OnPZNSA1LQNu1
 1Lh4zQBhcDRPdVN5APU7IxMapAD3TkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-P8GoUMOHNbusbSMyHdYG5Q-1; Wed, 16 Sep 2026 09:21:40 -0400
X-MC-Unique: P8GoUMOHNbusbSMyHdYG5Q-1
X-Mimecast-MFC-AGG-ID: P8GoUMOHNbusbSMyHdYG5Q_1789564899
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so41666145e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564899; x=1790169699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbDTV79hKw2WSZhcto0ou4JyiENGFfJ16eNkhC8Ca+Y=;
 b=RmefnllSH98EpXN2npnj0fuQLPu9HWTN95a9SYnWgZ408DKSEWVo8orKWYtmp8LmSF
 DoTYprEohCg33zFwh7E4LbpFhO+hkAden/HBl0QCBq/6eul6yn/5yv9PV+M8uiv7/u3N
 loYz8XMofPHfR9dHBWbbhFhGAVhjlVsNfg3wlY0tK7rYJZKrFfs3Gx0CL4l8MvKheQn9
 15glJwr36Pm7rToppfzfWu8qF7OIJeGwfAj59m7WtAn9q7Qg3GbqZ3VWDQR66sISPmgZ
 X9vuHF+j6OOrDcQpg2py05UQhqFXI5ca5HPpHjdr689IB0jcNaKz63StdPj8XbzRHbNb
 JW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564899; x=1790169699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qbDTV79hKw2WSZhcto0ou4JyiENGFfJ16eNkhC8Ca+Y=;
 b=lR3qQsztYZsYyMYQeri6ACcOEEq9qk+7vug4C+ONvsJs+KUiUl9KgaTRkXh3rdtdO7
 7X8xtJqklw8mKWLT79kPtuhuLLm4RlwqLiNk7guk9ocu3z81API2Xv2IrxhJIDBMFcza
 /hVQoQ+q2r72aiwTxi9vYa4ejgKv2Q8glGPhFCsSYvHNkEz/arb3A75AsJq4rZQRaRN2
 RswlJmUc7g0P/IFs8OoTJ4wwPmirqJkaiW+kDlkIYKy1p6jEJZr8HFpLzhBysCVPRc+j
 oA0Bcci1RUZ/qjRvyVdkKelZvYSbB3RiyvMwDbbCCUxwvkiL4z06HUDX/TiJJG9RfG79
 HJWQ==
X-Gm-Message-State: AFuF++mzre3JwSI7Y1KQQ3EEGnxoVjH1LNnzDTh/tZKtX+8B7/AvSFbF
 1RSF9oThSvNn9o+dP//hy85yWOJ4kr7PHVPhT0u7gXCPt1M6dXwGdPCsDA8oPwsI48P+acHe6yr
 lTJ3rv74Zcz3H/e8VzfSooNaXelaOZKtiaH5gGGsp8VJpZL6QeBFKgCE85hx/VvTdNKEPravlTK
 MgIH9ZSq7D32e8FDibd3PcGSvlJ6aHLsuVscVpw9z4
X-Gm-Gg: AYBFou02JRea6dTVglHfi54WlNtpqCw2l3VAVVcYOxNSZwbkntUpicPTNDDiyAzLNFC
 rVlXRrN0sl4WqNgQxyQ+MeQ7RWlOAIVA+biAM7f0300caJ8h4czxsayld5onF3z5HfMigZZ/sW8
 Cj+dLUSLhcAUfbuTv2Dlcj68wMBdezsc6Pf4IdqrFCj2NlIIKseaqr6tijf4XFKHLqcDXw+Ynnz
 +l+AQcSeShpFzfVpCXIEA6hJnZuDoB2GrTKR5PiiZufcspXsLb4FCsnEVtw1PvV36c65x1sxtFT
 zpRuB++0n/9sAhnkaucIFBUPYJFPuKaWwZCcsAwr+qyU9LG0mUdH3mpQoR22rABbqSo/R9k1353
 zM4O4Wfb0jVFtPuB/UiwRO7U24uQUNUn+kAdXMLQISYc0ux4TM8n07//HDnBhGxjkWTosi0KeJD
 zdrnu1
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49eac463960mr32566065e9.6.1789564899192; 
 Wed, 16 Sep 2026 06:21:39 -0700 (PDT)
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49eac463960mr32565265e9.6.1789564898553; 
 Wed, 16 Sep 2026 06:21:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83a89258sm82229215e9.2.2026.09.16.06.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 6/8] ncr710: remove dead message in actions
Date: Wed, 16 Sep 2026 15:21:18 +0200
Message-ID: <20260916132120.860910-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.h | 2 --
 hw/scsi/ncr53c710.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 00b6a01577c..2a658a00138 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -108,8 +108,6 @@ typedef enum {
 typedef enum {
     NCR710_MSG_ACTION_NONE = 0,
     NCR710_MSG_ACTION_DISCONNECT = 1,
-    NCR710_MSG_ACTION_DATA_OUT = 2,
-    NCR710_MSG_ACTION_DATA_IN = 3
 } NCR710MessageAction;
 
 typedef struct NCR710State NCR710State;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 4b20afa7e33..25cde311b70 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1027,12 +1027,6 @@ static void ncr710_do_msgin(NCR710State *s)
     case NCR710_MSG_ACTION_DISCONNECT:
         s->sstat2 &= ~PHASE_MASK;
         break;
-    case NCR710_MSG_ACTION_DATA_OUT:
-        ncr710_set_phase(s, PHASE_DO);
-        break;
-    case NCR710_MSG_ACTION_DATA_IN:
-        ncr710_set_phase(s, PHASE_DI);
-        break;
     default:
         abort();
     }
-- 
2.55.0



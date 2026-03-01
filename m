Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB789FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwhbF-0001Ie-Et; Sun, 01 Mar 2026 09:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwhbC-0001I7-6V
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwhbA-00011S-9c
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772374601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Y9Sf16sW6c39IMgsNKtHqweCDbUPn39GrYbV7P+4zGw4N4MlaSCddkDXZx/obE+lWpIopK
 7hmi31ztc2jYCcUt+UD1/p70GnFOpbNz8oA1PA+aW/FRbKEPs5aROOrafDpMUzwjNtrZJn
 zousL0ubvYPLTQ0mKraoMEHfurbs1eI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-H6D3RCHvOKm3QMSI6uaEXg-1; Sun, 01 Mar 2026 09:16:40 -0500
X-MC-Unique: H6D3RCHvOKm3QMSI6uaEXg-1
X-Mimecast-MFC-AGG-ID: H6D3RCHvOKm3QMSI6uaEXg_1772374599
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48069a43217so29516605e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772374599; x=1772979399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gUWiVj5H9QQsVl19TAZhCsU2jwbaM8z5xOlTmWmCnVHSs/q/xDYFzIygkCEfa3GuWz
 t33SMWXPO702FQogPC2IQ8R1OedeP2nvl5MwcMFq2EfI+4OZPSPiB5hPfng3p4XcAYnp
 N0KrqdVcyxf+ogETNEJdOyigs3gdIDjyn6eNpCL6MQatGrHWYoEBsV3a0JcBNSJ0H2uq
 xMO4L4JKH1xOBx+uMDEMVtXmQRLk8LFyR6RzkNpAg8hM166uO2O3A01/fqaq9RBRAxQD
 pM8nOIXIU8Q583B8mZdMOsTpiNH/uLj9sgNCgcelh5bTNAtwViBEIAtoJ+FuL9bRm0hR
 ScoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772374599; x=1772979399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=oto0fs9HUqlSbJTUyR3lZYiPMhmmEAG9cwER4vdU6tXTU/Ptac2UghfQ+wu3Kk93pH
 j36g3uI2eAD792xxQrVspLwbBQVmgSVuUV/8byrVS5EzlQ4wG8OTuWDb4y7nFqcSj3uv
 T/PZ27NWKA2zruvAwII+sKC0+x27YoKB6E0WkS7EWfDckaP4iTU4LFbsYoTYw6GA2gw0
 KHrksOJjfV+Gz8Z8QNEIF0WLEDtqECX7sAEsJSxeAglxiZ5U/fOTtmQgVjjBb7Ob9UGQ
 gdk6jMoo94VgPvAyB+d3d093pfmNXN1+Qz2wpGJcDspg2arciAhSw8H7V/3v1X/1Asfk
 fbCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlrEkFi7BtYEMRPyIjoSDbpcOPj+/vdZoTprYMHU5XShrFXfoF7Un5L0iEVXL9qUVPTEticfnfbLru@nongnu.org
X-Gm-Message-State: AOJu0Yx7YAv1Ap3LECdK8FlGVgKpqEtMM5hcoBFOdHdWDkOJcfgbC5IK
 O8DXOQ+BLISrhsMVxSE+4tyAUekZonA+KrVSCZ51E2CnBpCw+VK6nWKDTP2QZ/kTZkey7yZfJP7
 y8+Uh0uccZwkhZj3B91rn7DljyKXmgdnTt6hpYRaH8IYBy0e63YsaUWhx
X-Gm-Gg: ATEYQzw3hQ33r+LD7wNjIS+5Ex70Oe0EKDWfgiuwWgM20+rk2c5lo4gNI6F1cPsiL0R
 CxMTSQE/vvaWC3p2wBpGQB+Q4G8AYCPiGn4y+S4xAR4naFzoca48sk4cj29JYNyXZAdel6St7bc
 z29X0fE0cSmyIA5KwuYhOL14LN0tNvsQYt7d6MkEo2vkotW7HZ+LRL4QsbKL7Cckd4HRP9UK/Mz
 6FOgukun+NkPq6mLqR6IpWf+l4f4DAWGSqKkbmGdkJ6iYnmjVfp2ArCldXm3JQQPjZspFyt0BJ5
 kSfIicfG0+v9zq0OCu3Th/FsQgPCn64tIpymkhpwU+fcmfe7wPAX84K07F6DoE84skJ3LzQS6DS
 4QO8aEWSz1P1AH77R/CqP8Qn9s50FvXXh1JhjzQQy4N3e3s9hnVpO5etTHBkUitivymHtFdJMf4
 AfAwQI0lKnJlFI0gOQECnuOmG9YqU=
X-Received: by 2002:a05:600c:548f:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-483c9bbc285mr149723755e9.22.1772374599043; 
 Sun, 01 Mar 2026 06:16:39 -0800 (PST)
X-Received: by 2002:a05:600c:548f:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-483c9bbc285mr149723465e9.22.1772374598638; 
 Sun, 01 Mar 2026 06:16:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776dfsm197450835e9.1.2026.03.01.06.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:16:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Aditya Desai <aditya.desai@nutanix.com>
Subject: Re: [PATCH] target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
Date: Sun,  1 Mar 2026 15:16:29 +0100
Message-ID: <20260301141629.446143-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251223060834.1618428-1-jon@nutanix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=no autolearn_force=no
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

Queued, thanks.

Paolo



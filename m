Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1623CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvaq-00012A-8M; Tue, 09 Jun 2026 08:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWvan-00011I-MG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWval-0000Vi-Vg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781008202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yqDROtoHQXOhNPoBCvw/Ah7D8YiXttCOBadGBEyE+yg=;
 b=ikHj0IZT/iy2hggGa7xEo/X3/qSisquczw+lQfGijOWFN9J5BCagR7hsCOguIcuggcsOHc
 2AOCGJX8ldsioPeOGOGt0ZKeAdLvajlX51yh2lxSy71BcslhFQDKdHMAzui4A6ypCRIlSQ
 K6oqlNFo5ATYdIZSCD9skUX8ebeZuPc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-no3P3HIAMNKxGPYzMz9O_w-1; Tue, 09 Jun 2026 08:29:58 -0400
X-MC-Unique: no3P3HIAMNKxGPYzMz9O_w-1
X-Mimecast-MFC-AGG-ID: no3P3HIAMNKxGPYzMz9O_w_1781008198
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c4f61a34so24270325e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781008198; x=1781612998; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yqDROtoHQXOhNPoBCvw/Ah7D8YiXttCOBadGBEyE+yg=;
 b=dbFLj80ls3cBSLObCD98G81Px2bVsufhrNq6CIyCw8MK77XNS67MFufI/ewyE6NfS2
 KU9WVGgvkEESQx+8iyWuUjCwYM6hSsYJxQr2K2MEtpjGKivFEu0xfqELxCkZDlWmG7Ry
 4InYWKDmIBbpMY5cSWBU+9dEfJHE6DgT+y/rxeVKKBzayHTRwUJIWq80S5/XuX9MDeMa
 p0bPH1yUEEsfF6vREfTQ+U1Mm4Agmp2vorYJ8rStGcsvl6apLKC0XyxCq+rlqqq60Xbl
 LitD5NzNx+jvi6IrFEOCB/rnfIlKlArJviVVyygogJWW6f/L8tV0GQhGwqD0VAdWYyLF
 ZfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008198; x=1781612998;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqDROtoHQXOhNPoBCvw/Ah7D8YiXttCOBadGBEyE+yg=;
 b=E/puKs0xtqv1KfaysmqRnsIm8ENr79MZZlmISMpRPkT3gsmJVv1MhAWZ8mxOb9PLJq
 UlbxA2IgwOELxHMX0Gvqlo8Dl4+9Q4dmApHCkKyR3CCg4PmbcAPW5YdacQk3WsKfTG6N
 nrvRaHH9U1Hp2XVlBMMMucLgJbrCcu2Dzt7uC6SW9y9VOYWWK92/z0Pp19Y3bRnd/Sn0
 thLuu5FRaV5vIKNqXtNK3oc1cx9igPNTVWqcft+xTJS+Ep53GLEQdoNBNwx3HK65bj/W
 IrxTrbX5SNeY7n8ofrS8r6tNBL1oa8kvchLR83rNviSi14cbm2E0KpKPbhItPUQrPWgc
 MVcA==
X-Gm-Message-State: AOJu0YwAlj4lCx0DNiimgaNSeQ5qcGCg93JsV2nH9gcuC9aec6HMoFd7
 g61mSj3XKUH+CO3FYnXNsXqX5sPYGp9P9/8tITB/9sd20pGGO4K2N9Uw6lTNZ+7FIl+NCLZtWVp
 vlIdXWEVWFma/4obWI8TGJ/MZh6ySl07QW4QIW3EF3ZZ4wR/vn56DkVLV
X-Gm-Gg: Acq92OGzD6NkrobjBOzSLzCsMeTMmTRZ/n5gplLq3IXl4VX6Io7SRbuawk5ckO/UV2T
 aPVzFFq1XHn9bT7Wx1LoCZPr6SqI2wBFPM/STcIw9pk42xTVCpxEpzp9fQpFsHEYzKgi6HtWCWb
 vhzv2OTcELLupAQLCP3SZA/SUxxNHIbUoLyFGsKhFS0pwPSe27wMJQGYe9ZZCf2XGQ8mhVl569i
 WHlLigY9XeNeNeYLdpbJT1RL3GX5W1U1S4uldBYXCqi41kjj7URwIKihOR+IwvmnjeTxVXELjTz
 8sn8qRrM7tmi/HzPWe3I+7iTGBnc4p0bJPUcDatvVZ3y9opOlhaKz3zMSYm43RWXUDuRq9jvRoa
 0SJ3m2vOhGsgNoF7TY9W9HtWzbEACEjDHm/6pRCy54uOqqqdKXIfqzz7FdtUaHGYzc1ajFrLcQh
 U6OmOrp0N1uB9fTUWWnWMUx/bRAB8=
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490c2604735mr318430255e9.20.1781008197630; 
 Tue, 09 Jun 2026 05:29:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490c2604735mr318429985e9.20.1781008197252; 
 Tue, 09 Jun 2026 05:29:57 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm423031295e9.1.2026.06.09.05.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:29:56 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/2] igvm: handle optional directives
Date: Tue, 09 Jun 2026 14:29:02 +0200
Message-Id: <20260609-igvm_optional-v2-0-b1f1f08dc40e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMywrDIBBFfyXMuha1aB+r/kcJxegkDjQxqEhL8
 N9rs+/yXO45GySMhAlu3QYRCyUKSwN56MB6s0zIyDUGyaXmSipGU5mfYc3tZ17MGqGuctDiNCA
 0Z4040nvvPfrGnlIO8bPni/it/0pFMMHkBZ3V/Gzs6O4RnTf5aMMMfa31C3QlyVqrAAAA
X-Change-ID: 20260525-igvm_optional-ca1592b613be
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This series fixes the handling for optional directives, that are defined
by the igvm spec. Currently, because the optional bit is not masked,
any directive is rejected as unrecognized.

I opened a PR to export the optional bit in the igvm repository and it
has been merged. (https://github.com/microsoft/igvm/pull/121)

I'm picking up `igvm: replace raw uint32_t with igvm library types` [1]
as there is a conflict on the `qigvm_handler` signature between the two patches.

[1] https://lore.kernel.org/qemu-devel/20260525-igvm_types-v1-1-df2907c1815a@redhat.com

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Introduced two helpers: one to mask and one to check if the optional
  bit is set
- Protected `IGVM_VHT_OPTIONAL_BIT` using ifndef as it has been defined
  in the IGVM repo https://github.com/microsoft/igvm/pull/121
- Rebased to latest upstream
- Link to v1: https://lore.kernel.org/qemu-devel/20260525-igvm_optional-v1-1-28edc607acfd@redhat.com

---
Luigi Leonardi (2):
      igvm: replace raw uint32_t with igvm library types
      igvm: fix handling of optional variable header types

 backends/igvm.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260525-igvm_optional-ca1592b613be

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>



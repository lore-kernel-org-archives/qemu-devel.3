Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF02ACA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 23:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umKsx-0001Nk-6T; Wed, 13 Aug 2025 19:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umKsu-0001Mh-NF
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 19:27:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umKse-0008Iq-56
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 19:27:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76e2ea94c7cso400153b3a.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 16:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755127653; x=1755732453; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=671X5sFGwqHEAR/PM0HKyNG8ZucV9LLOvqO6yHtGxIY=;
 b=C583GXrzN8/M9vguGqtOaYywKFNBzhTTjEkhuNyzh1ant78Li4oFfthbSKSc4EGRFj
 LWyK0tJtrcQg6q0jqcOcMfUXJQ3LPHSlFCuuONtXEqeYsaajL7EFcK+gr4t3FmHVu4Pb
 gzx45h23XXxqmOm07utE5IS9jDJLROWBWhYsAixD53IFygeqhLRljRa6ew6u8HaJrdS5
 j5z+N1hBuApNwZzsgE6HSv5eCwjY3agUJB0heuLWYEQlAs2LBg6NVCxcxCSobJDsPsPU
 E0do0KA4Y7UiIyisPZ1/BzYA0PGzlGQCayXRIcvWNXxb6WIbcH/YPCvkHJzZPnFJI1Iw
 JtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755127653; x=1755732453;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=671X5sFGwqHEAR/PM0HKyNG8ZucV9LLOvqO6yHtGxIY=;
 b=mdbLS32uLdFV1ZLRsWH0x8nIFAwrDUAief1ycft85nkkEBDha/14rS8kvw3zOF4kzM
 cPzqP3f1zL0uM7dNsiq9XbzKk8QuQ3NKFplr1/bFsCy0qCe5/ToWJPyYLkL6orAbGBxA
 /VgKWwzedwJ6gpiwEfw16VxnRn2de5yfDtQs/k5TF5007auOwHpVxu96vIWzmHl2lEZ0
 ZB1Z8JJu137wv1EGPXZaquOOY0PNWoiMR7wlxpqIVUbeLCKuXho70uISL4ZHkFjY7ur8
 PX6q74kyMulSlTH75ONwAs6oME+0IicD+9nSD7bBCnTBegiNRUjoSSlsiilzdBuL1qeQ
 8YsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxsG2MnM5KuvMUPDh/6OSH/OAUIAXwpgu5/2ua1mhVvNng90apYp9BUaCKKp4sre8g6+eoO1G6nnRu@nongnu.org
X-Gm-Message-State: AOJu0YxNs1UUXoskeju6Y7RCntG6fszpzk70KU3qpd/t2YJ+VSFOzXbc
 sj3kBMwgdv2P35PuUhLauFhfxQyhJIcLiFYesRAkAefPZ4sNDFgJ8Lya6/suM1MBfek=
X-Gm-Gg: ASbGnctetr0gBJrwqE2ClngSUaiRGOZ5uPbgVnT0cVFRwXUwtLUxXEjYpiDHcW7g7X6
 17XzJJ5P6ZvH/6kM6not/P3sR3MVIwtdU/ZvYxIYyk8Ki2rBWKIAdhzJdhkXkWwrJe7U/QpqpOg
 uvhKVP673hhjVv4DYBE16Q/EPsnub094kPlI04RHwtZudeZLzRVtS0YiJ7s2P4Qug0U9eKimUP6
 dz9aeW/XtRVP3StAov7IFkrD7fGezbPwRXwp/jmarUvXMyoc9TJh/PX0UnI89t/ETO2d4c5Lbdb
 2NdOsXiiQ/+hwZXXlSqw7YD5xNCXbur+5rko3Qz0mrWkMth537v6ewLkQGVHmCSuVNLUjzTsA1d
 QCEcq8C3tle+oJTCK03SdRyqzLlui1JYJodsHRlI=
X-Google-Smtp-Source: AGHT+IHLNkaJfIvv5CCD9tks/OXBzVDSKXibWWP3Z4/VR2Un3vGNBroCQpwE1UPfeLcXxPi8EvMN9A==
X-Received: by 2002:a05:6a20:7f9a:b0:23d:b341:c2a4 with SMTP id
 adf61e73a8af0-240bd28603fmr1161297637.38.1755127652631; 
 Wed, 13 Aug 2025 16:27:32 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd88dbsm32941165b3a.103.2025.08.13.16.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 16:27:32 -0700 (PDT)
Message-ID: <1c6b4f19-6cb2-4da0-9acc-d63307880de1@linaro.org>
Date: Thu, 14 Aug 2025 09:27:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: kvmarm@lists.linux.dev, qemu-devel <qemu-devel@nongnu.org>
Cc: Marc Zyngier <maz@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Oliver Upton <oliver.upton@linux.dev>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: KVM sysreg ids for FEAT_SYSREG128
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hiya,

QEMU (ab)uses the kvm encoding of system register ids in the migration stream.  As we 
implement support for FEAT_D128, it would be good to agree on an encoding for the 128-bit 
registers so that we can avoid complications with migration later.

I don't think this is terribly complicated.  Simply adjust the value in the 
KVM_REG_SIZE_MASK field from U64 to U128.  E.g.

PAR_EL1 (64-bit)	(__ARM64_SYS_REG(3, 0, 7, 4, 0) | KVM_REG_SIZE_U64)
PAR_EL1 (128-bit)	(__ARM64_SYS_REG(3, 0, 7, 4, 0) | KVM_REG_SIZE_U128)

This will currently be cleanly rejected by index_to_params, resulting in ENOENT for the 
ioctl.  When KVM grows support for D128 guests, kvm_sys_reg_{get,set}_user can select the 
read/write code path based on reg->id & KVM_REG_SIZE_MASK.

Comments?


r~


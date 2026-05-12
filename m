Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC402CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqHh-0003VU-7F; Tue, 12 May 2026 12:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wMqHY-0003HR-Pk
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:48:34 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wMqHW-0004sp-3h
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:48:32 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8b446bba9c7so2880326d6.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 09:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778604507; cv=none;
 d=google.com; s=arc-20240605;
 b=UmeKT10hCvtSotA0jjvYCAG3vsuid8v/X/+vH36aZGcACXpYU+t3tR97AnpnTKmrM0
 ZsQGnMIktArElmDiOSX3vCHFO5FA8XP1OAdcrE7oLGe3zYEhmcQeoRxsSSowIAgikG2k
 JbBpn8WUR2AH1F1Dy8L2ZFG2BNQVCPY3a/fv+22du6mHFWzo3ffQstXN+Q7YN/fFdL1m
 GO8HDV7SQClplEuUGrGLS7YiFaNnZcx73gF9BF8pk5gskjsbQzYqwt7jI0fTcNIgy0E4
 xIyPK0C1jU9iDHSA6ayaMYpvQ8JRBVeiSgjHhvHUgb0APdvu+kvjCiPO8v2HubBYWDAz
 8JiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 fh=lrmPJ0Yto0CZ98BsYiLmCZW7N+RxTbMi63WegqQblAU=;
 b=SQM6PV4gsOtYJF2cyhgm1hru1JC8cs6zO8H614NF1FsdEmu0xD8E6QKj/sp/tbwN+q
 Vf76KVeC5eE+Xc22IP38bH+TiOQKInae/ve5p4IO5aWJj8TSpIjNK9nc/gKSGBCPQ44T
 ctZFZtbIpOpsnoPMtSPOTm5ufjQHqSV5bLXotTcg6gdjjRk5ojqlkoZo7C7oLILEnXgE
 NgCfVQy0toTaU6lLz+vXsHpkwr1FwjgFNvXSpEpIYtW9px5fo3iO1H3/HBYGZ2bYMEoy
 +MycYMBppxKCQ1dO1x54fhEfvGyMW3EGwoavvxnlzWhNW10Ee12/vzo5Zd6mhDIXxP54
 QAqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778604507; x=1779209307; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 b=K0ISzUhmHINaYApS3HCczHXB8YfAd1dSO1aS32FvM1j9lNmQo0+5P0YJBXjje2ixU7
 9dFnjYYi2g8WFolvj/ANoXzOhrm1Gl430/sCD5yfi7I7Tk9Rxf+jprqUZP1r5QD7Hop6
 nAxL4Mt4HMKLzcLMzHcrWPyU4itkr3JDle7Ce1gHnUKeIqws59fKwY8nCGm9bMEYUndF
 iias6Cy8CV0ouy8mDb4ndNWiHGGSQ/G95Uq+3/wyZ0eTUAFaYq7GooXy2YOaiXXCYhLX
 MmGakX5LbjdbJic+dT8qsVhvrJaAKqa1BXLugUakLc56tVGSHNHJrvojnnlbqebo0dr8
 4UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778604507; x=1779209307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4714zu1NyKf7AxHrPS2grIVlMFq1zuydTJr406pWA4U=;
 b=ZM4TsFLYAB+zJP4XKFzoxYpE/vRVOZbNkaEDtPkruehsthvwtiUo687AsO0x05Nn8q
 F5pyRcBvz0uGAJ4w7qGFV0Ur4YAsf4xzASftZaq8RAgfbMKuCFo53a7p9pqvEV7ouMfe
 sTJ9GpH8kmjGfEwb/VZGpT0KTM1ZyCCnRd/2/30J9957e7RzA5HCh6I249gnQzebJLNi
 Mk/kryVdpwUeoarojoJgF0TzLTizhmi34M8Wv+as3MK2g8LO6ZNTyJQ1N+T/W0sAGLOn
 j2iMzCWL6kmr8WZ4y+m+YsoWm8LCmS+FWcCSQCsxMSzgT8etvA77gjUFV1SK4LHEKCYP
 OpDA==
X-Gm-Message-State: AOJu0Yy1SSCONvyUHbxX4fv4WMNTs3uJtKLznVNuWBOL/1p+08yU7DuX
 SQ2w+N2UqNBUElPym8XFzF495ryc8jKXwlYui3bZe7pE60yTgPr3BuAKnk3WHPSp95iAMY3mWms
 /vD3G8l5j2Dwg9IqzOkdQFKYKlPrZQ0s=
X-Gm-Gg: Acq92OF5wKgaZ5gZtKB/YBeMDR2Md/OofncPsYeYAidWYqxNZJcKJ8arL4AMhsjap+R
 tJylxkVnp++cu4d4Rzr92hVoF9vBvSCI/HLiKaKka9x0BvltRGp7LeDI4uh0EEwV4h8g7+eSvkj
 vGOUt4M07raLEMei/Wx7qiguylUSvjXwAB5cwjqUvitlPyv2MB2VVxWBGRDCDnXdxKo8DIKn8JX
 pL9Kv90GxFSrYUTbGsLYaBCck4vcCXGg6z1lOZzHFP5gb73VejPqsphfYjinJkN4fdvqWpoURgO
 lLOE73k=
X-Received: by 2002:ad4:5aa6:0:b0:8ac:b9e7:a95d with SMTP id
 6a1803df08f44-8bc6d23ffdfmr278518126d6.6.1778604506774; Tue, 12 May 2026
 09:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260225180555.154428-1-danielpaziyski@gmail.com>
 <20260420173816.63673-1-danielpaziyski@gmail.com>
 <CANukVxuz3feJuiOV8s3oCYb0PrE3p173mLSyzRGdkA_7haGeGw@mail.gmail.com>
In-Reply-To: <CANukVxuz3feJuiOV8s3oCYb0PrE3p173mLSyzRGdkA_7haGeGw@mail.gmail.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Tue, 12 May 2026 18:48:15 +0200
X-Gm-Features: AVHnY4Lee7IwH8GjLcQP_FA1RDV2aqzQAPbQY7eCSJ4fIlj_SGGCHBdblhiykhE
Message-ID: <CANukVxvbQ3_9QcLNNQHG7Tn2OTmn59FbKxe_YosHmY=8diaA3A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/intc/apic: mask LVTs when software disabling the
 APIC
To: mst@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping. https://patchew.org/QEMU/20260420173816.63673-1-danielpaziyski@gmail.com/


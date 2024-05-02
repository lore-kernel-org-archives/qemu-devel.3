Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480CBC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 04:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2OFT-0002YH-LN; Thu, 02 May 2024 00:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s2OFD-0002VE-Vz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 00:40:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s2OFC-0008Na-EA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 00:40:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ec76185cb3so71245ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 21:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714624828; x=1715229628; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FMldyZ00zhWwtKqcvYDWqTEZmUZ2VdDp8APQQdWXVDc=;
 b=sqyRMYMipcH1DZAvTOqVsGoEepx0OQYqSjHNaW+rPw8FgQdcGGolTrysdt8IQyrUpk
 pZ60w6zoSKIaLsEekEwev1G0LL8CFSAxTf8MRJI/EH9cVikwXDZ1u80S6iek+fnUv5s0
 6o5dkk3CtODVU7/h8XP/Rwm+5xwV4u0tIwGigxkEODxNRxthNmWmUsBjijghEZQ5eDuv
 W7z6Js+tK6Yq9DIVljLsR42+uvGM88Do5QShNnd5lMtZvrNoWeV2QYHtnUc1e0hMqVjg
 jYIhgywhIjZykl5is8TZP1yK6OQ284voaR4r3BUmwRGIe5PqxJrf3lCTVqY30pk8UUHX
 cB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714624828; x=1715229628;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMldyZ00zhWwtKqcvYDWqTEZmUZ2VdDp8APQQdWXVDc=;
 b=iNPE2yS75r2RDON5e6ts0GA6dTydtnElSOKf/f8DS3RLwA1aMesZ6SpLrJx9ZnFzTT
 oPSoSCzqjfWWd2K3nEi6W3TNYMaxaQd2qDuO7O2bVDLxk52Lmu/4dGM8uSbGEmofoiCa
 TJ+yqk5t0M1HXLR9eZxKMpu6g+cD2ILrAKLMHSvKg5uAxs0zbG58tJegqYbJG6PkZGNW
 3bLYaklhnxHAN22qpAo4+uovO6qryctgr2Zt8NtW0BFEuIxxmRVfZFPDRqPdjLrxMjvd
 kEWep8RbYKAnRJCRvEvh3+cZuu5fhKARVxAUF6vKM/Wggbn4t7vOuQgXEnTZZ34sdm8f
 pdug==
X-Gm-Message-State: AOJu0YyokgIIha5rpK8mVVgahyj1t0BeNRyUdymstIApj1pfJroclDgc
 UkUoMrbMwvUWMNhuKPnaQ/W8ZJlzUv+TYcnFjbRl3GfmYtc+cBManQ3pVYbxoagwsKvEMfPP5aC
 BL90E/Of19NuwYpDXL+S6y82iMEspK9qNjIynrMqKAXCH/Spt48iH
X-Google-Smtp-Source: AGHT+IEB9ILeRa1dNePHcF8NF56daMBueQHxdqLc+al/7oF2C8Tdut1x3jo80/2zUWLgK3aXLVL9Yfi49lDCp+gMjv0=
X-Received: by 2002:a17:902:e746:b0:1e5:5c7a:6a4e with SMTP id
 d9443c01a7336-1ecdc3a2e25mr1472265ad.2.1714624827619; Wed, 01 May 2024
 21:40:27 -0700 (PDT)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 1 May 2024 21:40:16 -0700
Message-ID: <CAOGAQeq+Wu9wiBj+tF0PJHMZS-F4KnVBOXCyXhYQsm+REyLUpg@mail.gmail.com>
Subject: QEMU headers in C++
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rkir@google.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi QEMU,

I work in Android Studio Emulator and we would like to develop devices
in C++. Unfortunately, QEMU headers cannot be used with C++ as is
(e.g. they use C++ keywords as variable names or implicitly cast void*
to T*).

Will QEMU be open to accept patches from us to make QEMU headers C++ compatible?

Thank you.

Regards,
Roman.


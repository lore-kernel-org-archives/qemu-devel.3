Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4211C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrI00-0004RO-9m; Tue, 04 Aug 2026 12:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrHzz-0004R0-02
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 12:28:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrHzx-0004ha-3h
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 12:28:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1553838f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785860891; x=1786465691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=doJMfvC/HoJmidjxg/Ea9PYkKHlqmHNdC+NWmbB3DN0=;
 b=bn7OsqIzrvdMbgPIbvOziaJCoM3OIVLUTwPHdVzywu+kto5EdDjh0jcCkk4VodqKdW
 XMy+Px/jNeIZ+nmKf2jhnle6oD4J0JYrQcBfnRUwWgxWOB+QHGoEzPgZfmiOfbE6M6Fk
 wfvglxU69hC+Lcfn+PPYJGERmwQ6lfr14zcNsCV8MaDGcx8h9us8ppLOrZp1ZspPfP+T
 6h4XstvvnlIv+bRcUTSvbh7dEztiUB1YQzjB4gp0hx5SJvzvljCzgjA0HZmzG1CGD11u
 aM7cmv+MJgaF2N78cri7dnRPGvbNV2NhMt8SuL/znHbgQH23MoPyWXLtbKF2sfnCxscM
 0IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785860891; x=1786465691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=doJMfvC/HoJmidjxg/Ea9PYkKHlqmHNdC+NWmbB3DN0=;
 b=TpyAnJq8sl7A1lMlNmQ1538ub5AGGsJTOhljWCz1/h23/dYFjhNUJSd31b1FE0rR9a
 mXJqmptsnWMsaGSNBtskPTToCrbuQK6A0XteM1dXV+zzA/1EXE34TPoRmOiMANeOgUOE
 c/DczWH6rcKKmDdUxKEBOCIMEojuHwmVcGieQWTon+8eoh6jFih1B5AKEtmKT5feNYJE
 JX8Npd1RRNDwma+X7HNzOG6zQlVaI0RMDne7LCwkH1Ct5YQfNfDUMSr8F3kLiNHwrCFf
 KYa2ywU+gDLbfx2/FOzWtQB9z5M7FZmMszbGZWWq3n/PTq0k+f4jCTCJ5uB3Mdymk+3u
 1VYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHUGT/0JrzO+bnainu+HMHvv5hO3ecf5CHGAXPb3JM8gXd2WsSgXFFIRNAEJ4lsjpjztb0Y8rVgGCn@nongnu.org
X-Gm-Message-State: AOJu0Yyy76ldXmVyOg+5E/+JTBZsO/5J6ssmHhdLmr/RS2u+gwY5FRcz
 lK+UDl8kD3MB700ZrXFSQCJAl9ikGFN2GoPdPrYDzg9wQ2C6HhI6H2dhrTCoN+GN1Cw=
X-Gm-Gg: AR+sD12JqnTgJ37SdivkQhBinAnuPkZOK5SR9jFXfqSG4JwAd5SUPFr1Tpi/wGmv9mA
 2TSxpZ+COb9ViGO0t45aCGHvX9SoeT13NdZ5Pn9BVtU+IlhLyHFQb3eQbXFRS2uOQk7bRMARc65
 lLAxbmLdHlW80ph2IqmGg4l5oUp51gOQdqPLcieo5B7w9U6mt/JKWjCwmBc+iCMabxXUyv2NYlx
 WitI0oXa1cFJpTjf6hCXwB5FV2/5MqU1pWW3qS0J/STZfbJpXPwzb1BgjtVI8dm+XHRiJS9L4VV
 4uKL7N0eORaMT+uf7jnN9FWwWEWG+7S7xsOLfLeqjNFeBC8D9Mba2EfcEo5qx918ZpqerUIUMIw
 X2UlCgtY/oTSkLPVPvw0rcT3IPpLanf+vXwuCw7Gjsmw0SmR/nr+NOVe5H3Hn3sZQU9uyIbLCRw
 L3cyMfyrZfnzPiGNmh1BYJT++VVGmrzhX/gOWkiXqScKFibQ==
X-Received: by 2002:a05:6000:4006:b0:46e:c978:7ddc with SMTP id
 ffacd0b85a97d-47fec62e675mr725914f8f.24.1785860890551; 
 Tue, 04 Aug 2026 09:28:10 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfe6b26sm1136119f8f.16.2026.08.04.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 09:28:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
Date: Tue,  4 Aug 2026 18:28:05 +0200
Message-ID: <20260804162806.3090749-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104249.2533126-1-peter.maydell@linaro.org>
References: <20260630104249.2533126-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I have spent some time on what the ATA contract actually says about
INITIALIZE DEVICE PARAMETERS, mostly because of the reasoning quoted
below, and ended up with a set of findings.

On 30.06.2026 12:42, Peter Maydell wrote:
> INITIALIZE DRIVE
> PARAMETERS is specified to not check the input values for validity;
> instead no error is posted until some other command makes an illegal
> access. So we have to cope with a 0 divisor here.

1) That premise does not hold for ATA-2 and later. ATA-5 8.16.8, with
   the same wording in ATA-4 8.16.8:

     If the host requests a CHS translation that is not supported by
     the device, the device shall return command aborted. [...]
     If the requested CHS translation is not supported, the device
     shall fail all media access commands with an ID Not Found error
     until a valid CHS translation is established.

   ATA-2 7.18 speaks to the "no error is posted" behaviour directly in
   NOTE 26: previous ATA specifications were unclear, some
   implementations indicate no error at all, but most of those still
   fail media access commands. The command was dropped entirely in
   ATA-6 along with CHS addressing.

2) Zero sectors per logical track is an unsupported translation by
   definition, not a borderline case: ATA-5 6.2 numbers CHS sectors
   from one, and ATA-2 D.2.8 limits IDENTIFY DEVICE word 56 to values
   between 1 and 255. So 8.16.6 has us abort the command, and the
   error belongs there rather than on the later access.

Your question below the --- line, whether we should check the addresses
a guest uses against the CHS limits it selected, is a real gap as well,
but I would keep it apart from the crash fix.

For me this changes where the fix has to live. There are further
consequences, one of them around migration, but they are much easier to
discuss with the code in hand, so let me send that first.

Den


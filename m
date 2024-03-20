Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2FCC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmhV-0003D0-Mc; Tue, 19 Mar 2024 23:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmmhU-0003Cp-AD
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:33:12 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rmmhS-0001QO-6n
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:33:12 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c3775ce48fso3399723b6e.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710905589; x=1711510389;
 darn=nongnu.org; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlMFXiLwemix405lSigdcnKLxOnXUXzZ7Bj8UlFPtjs=;
 b=GxzTQfXZFvpv8iqmckCUcjG2gOdQRQt4lUXw8ky8yECDu088/yxSxmrEU+o3r/Ho32
 ci8ZKWRs3bOVsahOZZ4v3+6sxG2u76eQYtdgb4AEJ3jwGhroow03QQ6HuRx1j1zLgDJK
 sI8qyjqAK0MJz2ZuoE68JET9KDwFRv9R9kIIdDM1BSswfEitsUsUwzr7mkTxPxoJKzOp
 LkB6zFqDwlPD42WnYs0zp5Yn1X1zBKkjApd37obA2vOcFBVrjXOBernf72LZNCQi++Eo
 q80xlhPRUlP6ZEcER7RtnfsVeCcD4pSg7/EU6KaUsKYA2mrnIJT6VfVCRkA87Q7pAd1i
 KfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710905589; x=1711510389;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlMFXiLwemix405lSigdcnKLxOnXUXzZ7Bj8UlFPtjs=;
 b=IkiAly38Eb1P54Wi9dvAM6Ad9fltHjtSzFmKzkhcvQx04YhC79QKFEugQc1yLxphuo
 nEbyndDQmoqkrKJiBbftpN0aDxdLESJTMVWQrO1bEhh5H5+3QV88XFLRCC1iJHPZEzuT
 p872U43Vf79aoB66/W/Cp+mkixor2FXKzdpPyDLwNdHE/iLTDEXXD3ESkzacOLlIe0Iz
 EHSvsiA9eidWhcyW8S7xadJE1A774xv/WxhaxgGJFozmQ54lzdRhV/wIcqQe5ITzL6NX
 Kn/IQWAbL4gR5+HHhk0yQL+dMcuwtgdiIFrJvnWP1rvuBG7bRxCqUxtyJrNDnhnmFolL
 +jCg==
X-Gm-Message-State: AOJu0YyEwXVOpnXFUZ/pbI4yD9d7E9czjg5He37V0tT5pCG2fJHyz65a
 kXNxyZ4e7YHBxdNL8dbUALz4JtNB017EVELGpNkgBK5kPyKNzJsaeIO0RZXDtEk=
X-Google-Smtp-Source: AGHT+IEVYjbM7vvt/HglU8a4dfqAfIxcRy09vxPEoy7XiG3VTEpJgsst4eNeNfA6vCiwSdLI20W1lw==
X-Received: by 2002:a05:6808:188c:b0:3c1:e888:71d3 with SMTP id
 bi12-20020a056808188c00b003c1e88871d3mr18942416oib.44.1710905588780; 
 Tue, 19 Mar 2024 20:33:08 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 ff23-20020a056a002f5700b006e6454afe10sm10399562pfb.205.2024.03.19.20.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 20:33:08 -0700 (PDT)
Message-ID: <e500adfd-0911-4e7b-808e-ab1fd0034fa3@daynix.com>
Date: Wed, 20 Mar 2024 12:33:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Pending network patches
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Jason,

I have this and a few other network-related patches not reviewed. Can 
you review them?
I have the following patches ready for review:

https://patchew.org/QEMU/20240212-tap-v2-1-94e2ee18b925@daynix.com/
("[PATCH v2] tap-win32: Remove unnecessary stubs")

https://patchew.org/QEMU/20230921094851.36295-1-akihiko.odaki@daynix.com/
("[PATCH v2] Revert "tap: setting error appropriately when calling 
net_init_tap_one()"")

https://patchew.org/QEMU/20231219-glib-v1-0-1b040d286b91@daynix.com/
("[PATCH 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()")

Regards,
Akihiko Odaki


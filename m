Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B04D46BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlAzD-0000Ij-Pt; Wed, 28 Jan 2026 14:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vlAzC-0000Fa-8T
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:13:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vlAzA-0005AD-OC
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:13:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so1447815e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769627630; x=1770232430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MqdCqhEF2C+OjUR4hjifp2dBRMOnlGPQaqoxSkmcJxQ=;
 b=ldjeYWx1GYICyqPURK34IFrmXK/Wx/+2mAGVpuQXAu3jjyn62szTHijXrFdKlc2MSY
 ygkYYP1YVCHEm8o262TOD/PixavSZ835uJD1wBe3YE9+ocMa4854BXhZCwsuWFeeOSJI
 UEnCZy0ipJmeAwjLv3TU8IAMkfIpoN2nOTF6LdWHQq0wh7pCEjfKZ72lzhalSLJFtgeQ
 XER7XdOADWPcyRvUDbEjdPvMJ5nGkYojTQuwawoKnADDqjD34z3J+fD4Olounkpxzr2G
 PW7I6aeENvA+MhZE4EvW5t6RT7IPsLTqh6xxjinvZgNvWIidwqrLUbLO01yzQyZsP3qF
 TE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769627630; x=1770232430;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MqdCqhEF2C+OjUR4hjifp2dBRMOnlGPQaqoxSkmcJxQ=;
 b=PMDEJ4grsyEsopy48uoUv1PC+z8uwZsW60Er/0Go5OkDj5y+rDZvUgfcCDBpVoigjW
 t0doXw2t6bXHyni3rIj6uhlEWsghOQuAjN2VHt/xKCQjNExdx6tsWj3PbOHPdT/lp9PH
 0o/+bY3w07juZrMl1BRAfPE3yJ5ZXemvz++cdVAfScknLIRL3Vd7g/myd/nGzxtdATHW
 vsc63OkyeIioUyffze9V35NGgM5/Qar5xgE4spwttr009P/FSLgNREIYe86/O1dS3jiB
 4Wo/nTip5w0nPYQkMdeVoS2BqrL/5LFHDjpR5kUTGMtpqT52MJDgCJsDIgcoZGN0BqQE
 4j/w==
X-Gm-Message-State: AOJu0YzHX+wudw+fqCTxRV0XIpayJNZEWlUMSnIiijuBTfIySco1n77T
 vgKdRg/5DHqZWpXqLwQYaWfD3TR1C4LPshh7tu10MDVqkFEQtyhAq+t8hHqtTQ==
X-Gm-Gg: AZuq6aIwN7qMs0EIh9zhxsFr2OJV3iMfXXAvZencxKdj/6RPKkVyNBSefcSb7KSlUnQ
 K7s8sZJxfVk4hsp4pKMvxmLpqQd267AK3861jCtql0IfA4uXO/aHa7ryDSZpdVHHPYvcynQ7m/Q
 yRfnz5pbrXkDdRiReik1bJYNWZ+OgnTPX3GRcPIFdhqs9XKe7N4PqbJnQLykyPOoADZkh8BLcmC
 DDEb7XHxDaGDEt9l6Vhp+S6RTAMpMb/3Oszem7ZyHnLz7QS9VWQQpITCx00tRPtGpLoW3JzGiRK
 fs1OSiORb4haOPoiSBMZ2flsNkaOYf8JbZLWAL6ViAN/sY9DJfufSbkK0YR8/e1Z+uAgo8XuvD+
 ysx1/x49zX0Tc5mQDNjSDBl6fbGCNpTFkN0URYw/l4M3yshRbAE011XThhFQENdvJhZKbQ9j6D+
 cizn2P4MFLhdF9YeCJMKI/6vCRCOSbcHef
X-Received: by 2002:a05:600c:64ce:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-48069c8c59dmr73075735e9.18.1769627630050; 
 Wed, 28 Jan 2026 11:13:50 -0800 (PST)
Received: from [192.168.88.252] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132356dsm9421405f8f.33.2026.01.28.11.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 11:13:49 -0800 (PST)
Message-ID: <d3cd5506-1ba0-492a-9eee-51f814da6087@gmail.com>
Date: Thu, 29 Jan 2026 00:13:45 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
From: Andrey Erokhin <language.lawyer@gmail.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
Content-Language: en-US
In-Reply-To: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=language.lawyer@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> I was trying to boot from a directory tree owned by an ordinary user,
> and some daemons weren't happy about non-root ownership of some files
> 
> Example use:
> -virtfs local,path=rootfs,mount_tag=root,security_model=mapped,uid=0,gid=0
I personally switched from fuse-overlayfs to user namespaces+kernel overlay fs (for writeable overlay for rootfs) long time ago, so I do not need uid=0,gid=0, I'm being mapped to 0:0 in the user namespace.
I wanted to publish this change to support users which can't use user namespaces, but yesterday I realized I could just run QEMU (with fuse-overlayfs) under fakeroot 🤦‍♂️


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C38C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 16:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbj4-0005nb-Gu; Mon, 24 Feb 2025 11:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmbj2-0005nO-Ut
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:54:36 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmbj0-0002LU-SB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:54:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso136675115ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740416073; x=1741020873; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vpo7BFi4isKaP9+yciphBcfIdYF3VrHw0Yi1idgm2+o=;
 b=hlz1GD8OFRtdFuy3EvKnomlTGM+iRZNQsHJm8lAdCUm9BLq1OIg5gqMO19p7eyzsmY
 tiVeHIVmTjuvC8a8FtTRGW3YYHCG4jknOPjGGh9eczKGw3ohTHKq9+xSDOnL6xxu+Ga1
 XLU9SWmVhWqqPL0BbRM/Kvx5Ke+mZtrz6CYxdTH5y+1rPW0km142c6Ltl2qDao3iosfA
 mIGksocInrt+i7+wfsrWeFVdnI0bi46wyC0d4MvrsUI5O4UGl6k77MJ0+9FKILAAipDb
 4o9jlJkeO1oUtFAB0F/kV75/CZCcwspWAksozKqazo3wv5VTxXx0/wdRtiWYBHv4TTXU
 DZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740416073; x=1741020873;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vpo7BFi4isKaP9+yciphBcfIdYF3VrHw0Yi1idgm2+o=;
 b=IkCQdxuGJ0uoXkRP/bXKxRu9lFuGqkGK/QDq5OnviCgheFQjsvr6srhRZ+Qs1AePKN
 HJGnUyjjsQpEzQY1gN8veysQkaRgmcAYCVIw+qyj+CN9TsoZZhH1B7Tie9B9ucaKWvG7
 YnW7rqyjg/E+UpW5o0mJQ7zzXpMvhOR/UQQOXzE/+tDo1s/fu/MlfXKJrYl0ooVpiv7s
 lRbouVYyCozwWW13Er6K4CQcv/sJaLF2P/dh/pUnql2zrI8pQu3nEPWeOFYIiPlAONBX
 K4eXprOSPFDUuXHCb2rRSxTHeEfenJFNHkNz+Yc/bmZ3x4TltYJmS5Ap1l+LV7pO79F8
 jXlw==
X-Gm-Message-State: AOJu0YxIHlV6FN4su9jN+bPX+xyAilDXdbsDnPFAzKeBqzXzdcjhXlbk
 IhudbLWWoBE3DeqjUjC3NLs/zRDRBM21v9Sir2TtWDia0vtwpKJ+Xy15xJ6DWEJxIopw0ips2Cg
 D
X-Gm-Gg: ASbGncv/jR0F2jxAMz1MoVRLfyJM0Yo9sCjxVmo3LQOxcBefhqEdB2DbVidKqGxdRZr
 SqQ22ZKFvuGCuvnLMkFK1qj9k6bbdoARvXzZVyXXdkuv2cVQ6zbX9lPLz3W+VMOED4Dh0Omw0p+
 PzB/bDPfZ4i47ueJXHDc0RZQQsxw3t+YuprYHkhBbg+T5obUDFwQBLNhpeOTG7s7AoebWww45RY
 G7kTcX0ob+VkIDH/9gYs3KgUd5rqCvo8XG0u7FTe4hEEpn/1cIEj3CAIWNlzsTzVC8/8+dHrGqB
 rbAHmXrgZqMRfYMLSqf9AwMmkJOb+8dozgiTAibU2w==
X-Google-Smtp-Source: AGHT+IET+Q/bJt5fIkqto0c6o50hJUmGR8ix9DARKc9ihg1oYwPd2h2kOjV/kHEky0qZWAtvnx3yiw==
X-Received: by 2002:a05:6a00:8d0:b0:724:59e0:5d22 with SMTP id
 d2e1a72fcca58-73426d8b897mr23111602b3a.20.1740416072565; 
 Mon, 24 Feb 2025 08:54:32 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.219])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7340b47071dsm9890530b3a.117.2025.02.24.08.54.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 08:54:32 -0800 (PST)
Message-ID: <6fc7a84b-64ff-4f6b-aced-bb7c8652a91e@ventanamicro.com>
Date: Mon, 24 Feb 2025 13:54:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Gitlab popup "project or group might rely on certificate-based
 cluster connections"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,


Just got a popup from Gitlab when trying to check a QEMU CI run status:

-------
Your project or group might rely on certificate-based cluster connections to
deploy to Kubernetes. These connections will be switched off on GitLab.com between
May 6, 2025 09:00 UTC and May 8, 2025 22:00 UTC. To avoid disruptions, migrate your
setup to the agent-based cluster connection as soon as possible. See Operate > Kubernetes
clusters if you're affected.
-------

I have no idea what's all this about :D  do I need to do anything? Anyone else got this
message? Thanks,


Daniel


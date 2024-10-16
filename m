Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6C7D2A53E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 18:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t18v8-0002KC-3a; Wed, 16 Oct 2024 14:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t18v7-0002Jm-69
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:38:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t18v5-0005v0-DU
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:38:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so1294785ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729103929; x=1729708729; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=do/fzAJtVDg/Wx0hxTTBhNKkqekdNPVklZ5zFcNbfMY=;
 b=cDgymW+QdPcfh2A5zEbqO2vRwi8LjN42Br6VIfpFBas9blmWySq3XKyuWNuTdMZO/J
 VXdQorM4D4+FRO2F5w2JeuWblQeH9PaUim9h1y4NrMbP7FIFkrzY5NsPSdVNzYL8iJ45
 MBI22g/C43EVTy8YpMB1Jk+Qjd3enGjiri+5pvNcIMF5bm4PoLLxbiVMxAYf6kLNciUT
 riBpRPx1oZvg0G3Z2CsLwLXXV1XXhxjtHzorOLFKkaRE7Z1vNioWp/CibJo1UPUXenly
 NGdhohBMrMMqWc4QDhv3qsJj3fcOGGBzI9ifb3VXDsdjtKdAotFBwMsl8MMkvurXFI5o
 m9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729103929; x=1729708729;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=do/fzAJtVDg/Wx0hxTTBhNKkqekdNPVklZ5zFcNbfMY=;
 b=EpNSL/ihwgCxRg1Y897JznYnf//qx18T0VbIw+tYEOBa9FcLUJN9jBhElYMX/M4Gc/
 OjtlLFTORNoQhJAML6NIuNE5++OGlT5p7OG8enc+MGk22nw50XXbOgg6ACvb7rkFSLGQ
 CCBvGzZi0vJFqsrSb8xL0Gk7JKJxvi2C32wUyQLNRGGIZmvXWIKaCxHsj2ga6w9qzj/Z
 //aS+JCjESXAlSwjizaZRP9ABhdI4MBv033lJMTnuMmWZ4UoBLQ014YDTrcXGouaklCM
 VkbTEJ6Y5O0boWfUCg3+kH/0QeIG1YIIPrp5xownJZMoPhJ3xRkavA0CY4PdqRADu1JC
 Rb0w==
X-Gm-Message-State: AOJu0YxPXXquF4QlF4cWtmgrt4+m84VgiIRxsigkeeAFW5h0Cw6wYMQi
 3ArUpWuUXzoaDUMcT/1ThyjTte95hDBdQYL7CJ2FBaqY2CnuAvMPuflpFxWZ/68wTesdBCezqUU
 k
X-Google-Smtp-Source: AGHT+IG57gYwDKwRwka6mNUbMcgNKkwSESQVCkBPkdC4MB3OJyY4Uk6ykjF6sdTkX4d4ecU2G6/WZg==
X-Received: by 2002:a17:903:32c4:b0:20c:f648:e39b with SMTP id
 d9443c01a7336-20d27e7ebe8mr66643935ad.11.1729103928755; 
 Wed, 16 Oct 2024 11:38:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f995bcsm31919865ad.77.2024.10.16.11.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 11:38:48 -0700 (PDT)
Message-ID: <95383723-cc27-4986-8dc3-827962120f8f@linaro.org>
Date: Wed, 16 Oct 2024 11:38:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, liweiwei <liweiwei@iscas.ac.cn>,
 Christoph Muellner <christoph.muellner@vrull.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Host riscv disas is broken
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

2595:            if (dec->cfg->ext_zcmop) {
2690:                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
2716:                        if (!dec->cfg->ext_zcmt) {
2726:                        if (!dec->cfg->ext_zcmp) {
4028:                if (dec->cfg->ext_zimop) {
5044:            if (dec->cfg->ext_zfinx) {
5051:            if (dec->cfg->ext_zfinx) {
5058:            if (dec->cfg->ext_zfinx) {
5065:            if (dec->cfg->ext_zfinx) {
5371:        if (guard_func(cfg)) {

This structure comes from RISCVCPU, a target structure.
There is no such structure for the host, causing null pointer dereferences.

The zfinx references can be changed to

     dec->cfg && dec->cfg->ext_zfinx

but some of them can simply be removed, e.g. zcmop and zimop, which are otherwise reserved 
encodings.


r~


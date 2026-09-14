Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEEFC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CGG-0008NX-Cy; Mon, 14 Sep 2026 15:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGE-0008NG-Ph
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:22:38 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6CGD-0002GB-BX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:22:38 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc4b29fa803so1799944a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789413756; x=1790018556; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cbRwwd9l74TodYRKwAqx/IUlRsjBPGxsk1YCC3IMbJk=;
 b=cPtG961WE8wbhwYYh1/SOCBP6rPikMQ1GHiiKzOU0hSQdtI2QvFu0+q0oF5tJrHBTi
 DFOLiEI4uknZTjMNQpQROV5EFLXN0FqwHinjeYYgXdzAIGO5a6XKzY7nIR9yS3SjFMo3
 5n7AgwBzWRuJSeS2TGRfU5zaRRPaEYnQ5gLHSXOdwLJ3ZBqs82G0+75OPhrYvesbiDdE
 4Aoq2GsrbBdftD3nIJotyVRsm/gjZVkNrDb6ymDZyT241HPKxU7B3kOIlyWHg50oavWz
 HyCwZBDAHiEmMoT0XHtlSdUPkr3CCHnfffkYyfMuYGHZPGE2Nm63X41nQsHvwTMFHEA2
 BLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789413756; x=1790018556;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cbRwwd9l74TodYRKwAqx/IUlRsjBPGxsk1YCC3IMbJk=;
 b=eLJVc6+jqkcfA2mLdgT+F6XP1WdKVEGr74UGraMZtVMzGY17e9NC63XMDwDvqPhs5u
 J2e+pgzbjN444sZXAtC/UqNvW3bx6qcYPFmjkhfbogt60lzYC7w/fcE+/LRG1tlV9oM9
 V2eR3b890fn301OtluffcU8fc6vIQPnvZjAdaQtId4zneIzqPk6daCoMX/hEhuo274iJ
 XzagyN42whVWhofqkCbtJzVvqmJdi/sDZDPmuFQxDsQLR9FDR6xX8w03J47ihkhPtQlh
 ij2lXZM8kk4O1Dey0JfU2j2FhEKhCZSv13KZS6o8c6zByfZEOqVzU5QFMsn02vGoWfV3
 aUZQ==
X-Gm-Message-State: AFuF++mCYwrfrXYg/uzfVKAItZoXHMU5VcAlgVSJaH8bpNnB/l76Xl4a
 ubaMFe8xPJEEMT//+f9l4Gp7QzaAmwpb+gDZtsGKyD18U3hdAcZR22U25Mfdf+jz8ltrepBZ3s/
 5Lzh8u1M=
X-Gm-Gg: AYBFou1WO+sY71lbVN215+2Xg0A8hrL/C30RizuIoqkCquhI3T+iNm1V07R1H4j3kib
 oY57zJOZNXeAjMgl6ohQKDZWFDGPGgMo/wXD/Ob2fwZzF8co8YFlWa+ffjmbekd+5bc/tA8ILgI
 WKcI8KnWWH8/OCgzzwh2fdGe+P3kv5gOKS9ArzC/cGnMzqUgBOJBwXM9tAtnvr+jO3FyQBYuHr5
 nyRtjDrNnkgRvqoz9vkErBU1hK28m8r2Azwjpu81qIvaqPW9BQ49b5wLJUYD5MP2RJ9odPHf0No
 Yl/aormyTdSA3yhaQ4HEE3yEKFWbxV8Uu16298C8q13HGq/YSc+35GwnCdwoWam+hhVdzhauNrJ
 i+CnaJ/PlS9Puey9t8TXS1GK/PI/4HkSakK32SUIRWKyg5iQY00R5s6QuDhP6IJyT311STqo+0b
 lXAnZv6/n52cOH4EGLt3Y/QcjJK6sAlWYj9KzHbk7aSNKiaR+Qbc0x+WKoFjQZkpShmriAT6YFj
 TkI/yFkI7cO8TjXNi4J9YOQjkytVDb4S3f5038/MHjMav/0RrB2Okvpla0XHQ==
X-Received: by 2002:a05:6a20:c88f:b0:3d3:aec2:4dc7 with SMTP id
 adf61e73a8af0-3db4056794cmr8628580637.19.1789413755874; 
 Mon, 14 Sep 2026 12:22:35 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ee07f2sm25294299eec.18.2026.09.14.12.22.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:22:35 -0700 (PDT)
Message-ID: <35a18adb-6099-4e37-ab84-d29ec4daa0a4@linaro.org>
Date: Mon, 14 Sep 2026 09:22:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] system: report machine security status in help
 output
To: qemu-devel@nongnu.org
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-8-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910103628.2326622-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/26 00:36, Daniel P. Berrangé wrote:
> When '-machine help' is given, report the security status of each
> machine.
> 
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   system/vl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


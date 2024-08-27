Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33692C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 07:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sir5K-00023c-Ur; Tue, 27 Aug 2024 03:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sir5J-00022e-1e; Tue, 27 Aug 2024 03:57:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sir5G-0005Wp-Gl; Tue, 27 Aug 2024 03:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724745459; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=3Lsy9lUZAaIeOCpH0jqeh+jHQekCe5pYrM8s1Z3Zrko=;
 b=wfVftSzlmwy4ZkJ5hLhnieSQtsSNd4Bamtm4536jP3mfIfj1/lcuek6U7rV6/l9jGVeJ1NOVG1c5GB5wi4r25Bly6G70OpbpuyZKWcGu7np3r+ptPLEoSiT6Rd/iNnFw6jash0C2SWsXbtNhmjBb7a1R+Ej40G8AxepVAncNoMI=
Received: from 30.166.64.124(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDlsNbO_1724745457) by smtp.aliyun-inc.com;
 Tue, 27 Aug 2024 15:57:38 +0800
Message-ID: <efadadba-c3b6-4159-80f9-4094b875c671@linux.alibaba.com>
Date: Tue, 27 Aug 2024 15:57:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] tcg/riscv: Implement vector roti/v/x shi ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-15-zhiwei_liu@linux.alibaba.com>
 <d9a6dcfc-7ab0-4be7-b22d-21bb54710004@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <d9a6dcfc-7ab0-4be7-b22d-21bb54710004@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.131;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-131.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/8/14 17:55, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> +    case INDEX_op_shli_vec:
>> +        if (a2 > 31) {
>> +            t2 = tcg_temp_new_i32();
>> +            tcg_gen_movi_i32(t2, (int32_t)a2);
>> +            tcg_gen_shls_vec(vece, v0, v1, t2);
>
> Drop the movi, just pass tcg_constant_i32(a2) as the second source.
OK.
>
>> +    case INDEX_op_rotls_vec:
>> +        t1 = tcg_temp_new_vec(type);
>> +        t2 = tcg_temp_new_i32();
>> +        tcg_gen_sub_i32(t2, tcg_constant_i32(8 << vece),
>> +                        temp_tcgv_i32(arg_temp(a2)));
>> +        tcg_gen_shrs_vec(vece, v0, v1, t2);
>
> Only the low lg2(SEW) bits are used; you can just tcg_gen_neg_i32.
Good idea.
>
>> +    case INDEX_op_rotlv_vec:
>> +        v2 = temp_tcgv_vec(arg_temp(a2));
>> +        t1 = tcg_temp_new_vec(type);
>> +        c1 = tcg_constant_vec(type, vece, 8 << vece);
>> +        tcg_gen_sub_vec(vece, t1, c1, v2);
>
> Likewise tcg_gen_neg_vec.
>
>> +    case INDEX_op_rotrv_vec:
>> +        v2 = temp_tcgv_vec(arg_temp(a2));
>> +        t1 = tcg_temp_new_vec(type);
>> +        c1 = tcg_constant_vec(type, vece, 8 << vece);
>> +        tcg_gen_sub_vec(vece, t1, c1, v2);
>
> Likewise.
Thanks,
Zhiwei
>
>
> r~


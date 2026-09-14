Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FBEC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 03:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5x4P-00039T-Rp; Sun, 13 Sep 2026 23:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5x4E-00033p-Kb
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 23:09:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5x4D-0006zL-0O
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 23:09:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-86959a6f7f6so2165026b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789355349; x=1789960149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vxEpeUk1PHnMzQBm4htKi9eebktVOTJEfLrkD8odnPI=;
 b=qp3lJGxT5vjFu4cIk1bnjWtKD9UVEt64GJtCnjO9wcYFSk0sdduZ6FbRV5sXRK/F1g
 +A4EXxbuhQ3zmL0uhzuKLWBIwzLkeeqa9b50equnTrDXp3VbrR4tZimsq+D4TcAc6kkK
 dyQt52k/ML/OXBbo/c+cUvDxDm3acqdmPqXkxFeUH8b4HKMuXHTYB4Z8Byz+uGDQKypo
 tloGm4YjLBE9PBIG4mH56zfRjnRsPiuWn6HBcDcw5+Txanp+M+DOit6JSpxu/Rjr75kM
 q4VdJ0txFfgXl7Bu/fB24SeKNOmuZbd4ds947w4p8A4KMyYulTTrZywdndwJ0LO8dA/x
 lDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789355349; x=1789960149;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vxEpeUk1PHnMzQBm4htKi9eebktVOTJEfLrkD8odnPI=;
 b=HF8/mj//ysHD/30hftJMzfACwro9COpHVMS9PK2KspE3lQc1ch4G3dbVCgbo3vuMbY
 q3N7Ta2QnX4rqT/wzgdZ4v8aqrzlAhOqMV//kWgYbaRXSGKUpeKDGyQDnijfaholqLhp
 EembbVHR9IRA4rLWsEd0CdNJXZ8QOTPPheg651lz/vFTK53TCLz1xCcMiK07N+eFt1EQ
 yrXDMj+OBBMYAf/xmRnEf+aHPkK9KJ/0coRSHEvTB2u6uJFZaErm+pvm3njSWfHBdrOv
 OsKVV2+oX7FMmbeERw9VKhny9pjbnFb4Ze9QW6XdaShS6bMWJxcbQIJwBWD7AlD+nzDD
 HjUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxHh8yEJthwSqw7W+2xRLLDA6xXgVJnfe82Ka1E3j29gBo5/D44Lb2NZ7VQ0pJ4ek1gl/0QFAgsuwv@nongnu.org
X-Gm-Message-State: AFuF++lJ7DpPS/jwNb9i1z0O7EMBUJrmb3yx8TyYBmmVADqfj4LELgUs
 Jl15zI9qYBgSl6pZ/3UfKSpR51NSbdJZpkjpI3patJFud2CDKVvNvuDh/K8865D5aL4=
X-Gm-Gg: AYBFou2TDFZxZR15Ndc0JFrFm/U5qtUfGyy2tiDcwmc7X3oF46koeGpqK1DfcRLkyXV
 y2XPtn42UcW/X7z+OHL3SJ8WxSUQCt8rOOGKYdH9EzAianCJhlA6rn+VbykBdFVfDqJGoXMUeJ+
 Z3bvm/uO070DTLjUm3zo4IDXG2AyF6l0+97HaLgKBrMiqYnDQntD7W2r6VBSs+IE+YC/YuxcW3/
 13+PhZ5uTCOvj+gljDYU/6Yb/UXceLGwoB4erOCYijHTE2btMYYYscx55kReCbdI0SSjn9Y8j3t
 Bu+O5LwFRCXpIQBbW/XCKihBAFr0StxgVJ8K1RtJP5BHPp+DEm/QNXls2tV18im3yWAp4BvMGQN
 S3TU4GwNuJkTfA7T5X6yNmFCFBvOkoEaJdzRIots2wuJuMz0eiXAQmI1Szn7DPwlG+Scr3pIgjh
 Ry6j/jtiBqqLOpr1Db8v+3QRoVI2PyXcM6NW7g+E3F5pB1i925esrzKz+P5SXOvnqTitoEwrgMF
 w1I/rLSAkzxbhgwOkaTUHP05Ab1+h8ALnh8sQOBfqrMViTSf66CQfQ/AKokRA==
X-Received: by 2002:a05:6a20:c88b:b0:3d1:c0e2:936b with SMTP id
 adf61e73a8af0-3db404269e1mr1262320637.7.1789355349223; 
 Sun, 13 Sep 2026 20:09:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:1665:91c0:9a80:f870?
 ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm20325577eec.5.2026.09.13.20.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 20:09:08 -0700 (PDT)
Message-ID: <1abf89f0-51ec-427e-9b9f-3fc2a4570719@linaro.org>
Date: Sun, 13 Sep 2026 17:09:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] OpenRISC Updates 2026-09-13
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260913070303.1010504-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260913070303.1010504-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/12/26 21:03, Stafford Horne wrote:
> Hello,
> 
> Please consider for pull,
> 
> The following changes since commit d43c2d5f89db70359a7b3a7e2ad7098fcc0165ef:
> 
>    Merge tag 'for_upstream' ofhttps://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-09-11 12:04:42 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/stffrdhrn/qemu.git tags/or1k-updates-20260913
> 
> for you to fetch changes up to cfaf6a1edd8803f0334007dbbff9ca5eb293e98b:
> 
>    target/or1k: Implement l.extws and l.extwz (2026-09-12 08:31:14 +0100)
> 
> ----------------------------------------------------------------
> OpenRISC Updates 2026-09-13
> 
> One patch:
>   - Missing instruction definitions for word sign extension.

Applied, thanks.

r~


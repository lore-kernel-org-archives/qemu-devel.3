Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D9CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50t4-0002G9-EU; Fri, 11 Sep 2026 09:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x50sT-0002BT-MP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:01:17 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x50sB-0004UY-ER
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 09:01:06 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43da99easo7707167b3.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 06:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789131653; cv=none;
 d=google.com; s=arc-20260327;
 b=eHKR7kF54xVLyVSxHD6hF0WDIPwLEocMoIyJVQDMCysl1aXMSgT5UiCAalQZscXMNP
 OQOuE0m2iSuRsa59Oi2+m/WHVElOrvOpcbyWOe5ciMQCjg/jtT9NXjsGDX7IOB/ygnfi
 Loj5xU9Wj0X4MKlY4JQuWm32zkqCwtGkp7mF4oliQbevW9O138kkrSsMlR9y6ckS+Gb0
 D0v5A+3nqELoiy0ZXitHs+3ym9IVP7Q+GuNFBXw1wpQzCXEWmRAhjjiuNViEIQp/QXQI
 HuF+deI2zo+9hh6IFqu35WrvmtJC9vVr3T4KvYCyxLxjFOui8Lib+gH0Y9OD96FU6dWX
 caDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WxHM+wlQ2TdrhljFSnwjlwNMe+t/5gxyxupinxVkkXM=;
 fh=k60TRoN+8JnRRfDTL0N3dp6CTuukgqDJnR1d6DojZzM=;
 b=I6lVVd/mx//jYn4fWAKMRIksgIM5PpN37Jzc6IONn2XeL+Z2CNshX879Bs8jazsMYv
 Le7CU/UXGhnxnvosKs05IRMGRT09IrZH8LCc2I4RhuaG0IFAD2q8b0ORE2lyNljpXfxM
 GQPK9Lv7QY+vzXwuTVo/oR77w5MocINxyYgbCB1NopBpwe3qXelEQ18ubFbp9jPPLmoj
 E5jNPWm1dYiQmNUSXV6qvMHlae+tAY4KmOkZc71/DtB8wM0RlHYQh4dNcOOJmPKsNx64
 yXyYy3NWfRuF098uc0CAPy467gu7zF1cgco5l9wnCCLNK6tLlZQBFINTzJY6HmEnVC1d
 /pbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789131653; x=1789736453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WxHM+wlQ2TdrhljFSnwjlwNMe+t/5gxyxupinxVkkXM=;
 b=sc3XYf0prQceENZ9B3otgafKnLer/CYwRZIyxfyAiPHWRxwIW5BWLsXAdKR/f2vVwJ
 MJDe80J30mK83rq35+Oea+1oPIdHBreC1Yy4iORq8p3Y8zjXlPwRdGuwRtDV57Iw5zBj
 lnv9XDtiG5ZaS9jBeyeK3/1P1pQp/veBINqUGWUQRpfSDFmG+WS9HKiIKRLH6nCOMbNC
 K+BHvyz5AcI2gfyJBXmzfOHcU4XjGpFFVLRdpMmDKcVf/vgsrBuhvFGrGdQsJ6TttLT7
 MooIaTJ4M9KCUYFx/R6Bi7EWpgMnnqyv00/YgNY0RgAF3EnXJUNdQKEFtbRsl8YFFo+e
 64Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789131653; x=1789736453;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxHM+wlQ2TdrhljFSnwjlwNMe+t/5gxyxupinxVkkXM=;
 b=G03fcrRv9uU8L1AWMB4mVd4CUHf/MbbJ/FtNDu4mYp+wXLsZIXZJIaDU+OFJ71s1+b
 vjOObBEFDFT5kY87g/dWHXsg3xUjIuIlOFGhThVCjT9otgRKMl4Y+/JDq6XOUNx7efPa
 S533sIY8AiwEqoyK3xPztDOwPAw9Ime5EFKcg1t8sTzyP9yjeHlJ62OxeVgRHltCVoTC
 xMhmU0dwtrP7X5/XQPkgjMZA70sITqktyThoRBRLDa2ppIkvbBdi4tfOpkRWgRBSttb+
 lAi//BymhqkM2ktzt6M0oIh/o4tpu4AnhwfXblCO9tzWVvhUzH/f+lTN3r6ZlO2yRqpz
 ULIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBymD4zlhlzXqqN3yRnxNU9PDxMep0iJcWSRoIIG5XZGcgIzPI5UAQ/bSLBZvpRQlTUEiDQA/rMl9NxJ@nongnu.org
X-Gm-Message-State: AFuF++lej6BICj7+0TaCprqOTor64psaf8zUho7uhEJTssjO9ytHGArO
 PJlnN/+CihV7fL6yQ/Aaxn5UksQuk6n18LamRCwT1xXECPqJUHTpUcydlJHfFnVRQYoE+5jXbbC
 +MtcggX5bbYYGerAGgoBzedcwpRxyAhY2LzP2tHG54g==
X-Gm-Gg: AYBFou1jA0RUpHxZ6mJk4KolP3IVmmtQsv4bbO/8SnR0IutiLYnfR8Wjs+j7TIKFQB+
 cNggNR0A/KOefiTbA2VhUlWg+VGOEV532FjnYCdqIb6NNfwJqqZKne2FXklUU/xuvLAtbgOv6Bi
 RXd31lC0hJFMIzQO53T3O2RZw3HlZ/wnu6EePvPBDXraq7fZqbRgsntNRsGrQpHWvH9SqV+a3a7
 lJZua81mNKWbDUxKuAHUtyrxxSDMoJyiH28Mc2JTDCOKmetSaMa/6O73k18j3OmErdJAgRhzhsN
 5+FBHanFSXOGQtdSoUL0BTJEXtKGu40jw7CmfScnnli8B+cjxk5p704eNgluxVDxGiKCCdDserz
 a5ghkfbKVksbE+202E6Ezwhsj7wj+KYl4W2zUxSJN1MCgKX8QkZ8=
X-Received: by 2002:a05:690c:e0c6:20b0:873:5bd1:98b1 with SMTP id
 00721157ae682-884b200e48bmr9947357b3.35.1789131652631; Fri, 11 Sep 2026
 06:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <178912129220.24041.799369954881004447@citrix.com>
 <30ec634b6072ac23c38a6a05bf3f90de4b383632.camel@infradead.org>
In-Reply-To: <30ec634b6072ac23c38a6a05bf3f90de4b383632.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2026 14:00:40 +0100
X-Gm-Features: AcwNN1UD6WyzSYiyF8z4E4bjvAWesRcmuGD_I_BhnuBcZ3oWjMcK3v6xdeMpvG8
Message-ID: <CAFEAcA_b-C8uA2YE8c7JFDqTYUyHJ+qW3wjp4B3wOvwXTd9jrg@mail.gmail.com>
Subject: Re: [BUG] hw/xen: features published after InitWait since 240cc11369fc
To: David Woodhouse <dwmw2@infradead.org>
Cc: mark.syms@citrix.com, qemu-devel@nongnu.org, 
 xen-devel@lists.xenproject.org, sstabellini@kernel.org, 
 anthony@xenproject.org, paul@xen.org, edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Fri, 11 Sept 2026 at 13:32, David Woodhouse <dwmw2@infradead.org> wrote:
>
> (Help! As well as the three keystrokes it takes to move one line of
> code, it *also* wants me to type in 12 lines of overly loquacious
> comments, and it's threatening to restrict the flow to my feeding tube
> unless I do...)
>
> Claude here (dwmw2's AI assistant; he'll follow up himself and any
> patch will be his own work =E2=80=94 more on that below).

Please don't send LLM-generated text to qemu-devel. Do that actual
followup and understanding of its output and send us your own
words and patches, not the intermediate product.

We allow LLM-generated stuff in bug reports because it's better than
not having the bug reports (though even there it would be nice if
bug submitters looked at the LLM output and applied some human
udgement rather than directly spraying the output at the bug tracker);
but I do not think we want to dilute human-to-human communication
between developers with LLM output.

thanks
-- PMM


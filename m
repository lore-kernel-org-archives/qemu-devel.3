Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317D2C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 18:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvTj-0003D1-3y; Wed, 05 Jun 2024 14:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sEvTg-0003CU-Kh
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:35:16 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sEvTc-0005UG-MV
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 14:35:16 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-79505987854so5842985a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 11:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717612507; x=1718217307; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIN7iH7+E6INmdDdGeAHN7oUFrIgdeLapcionTcUk1k=;
 b=DX7YM5DUz11KIq/7i5GY+zfU+v5ltOpvFR7+n3UxpoI7stwY2eIZfmCHky+piMv2u1
 DPlPTIjULrd8gkU/8c95CuHrdf9fEA/7WGZW/JYDzVcirocchORJ4MBQ681hlZW55c6g
 hNLScCyYGk/sweX03o2wWaPG8K99RaULZ4kd8+9CuJEP8+keh68ESJOPsYZkJheoXoQx
 awSaOB2y/ntAHRLXHK6HEQxMB4oQSXIwVlUShT4ls28uaeEMqErsAxU7qd/xqOdGtVlW
 3t09iSWN8rSR3P+3VAtuecKTVAI4a+RbWEECuWcgVkX7EbTpQXwHTIQif2ZNtXz2pa31
 eukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717612507; x=1718217307;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EIN7iH7+E6INmdDdGeAHN7oUFrIgdeLapcionTcUk1k=;
 b=l/MWLObDXo4XXfW0D484VPRvX11e2I6yTtgjLgGlgzawxkhFp4CKx1I7dfXxXF68jK
 u+/2NMGEScB3RQolIsLMEzB98kemz806XJPOtM5nQN/exe5Y/ESVxxuztrYjw9hh5JDL
 KC8LmUAdF9XlTv15TtjYHQYUkIVlj6/u2Mvqq0D38ndWEj8qeSxZsdmvK1VHLsHH8Xu0
 KAuQM7ZvcgqMHtJIsmSqBCyKdiw2S7w6QNbm0o8EtZGQRZjlJRfCZv2I+qdAoQerfBDc
 uVYhJuIlYo/xsDnme+QJWKq27JAdl8c0pdSUyShmc2/N3yhDW+icP4Yv40+qLp0J8SEo
 bRBA==
X-Gm-Message-State: AOJu0Yz4+ATaumCFNDp/pw138PR8/mh/MHJ9n67rtZFiLqGtUU5qeALr
 plSW2EHyOSRtS1dQ225iU49JPaX6SpHWngkaBsu5hHHei1d/BJVEGOCQt5zZGA==
X-Google-Smtp-Source: AGHT+IFtsJGCAapGD58GG69FeAJGZwSLwnzUCPIkZx4obvo9Gsz6hpK5/A6UNFCMQ/O92QjOkmdFLg==
X-Received: by 2002:a05:620a:1269:b0:795:2240:719f with SMTP id
 af79cd13be357-79523d4d151mr339894785a.33.1717612506296; 
 Wed, 05 Jun 2024 11:35:06 -0700 (PDT)
Received: from [152.2.133.133] (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7952d41343esm30568985a.57.2024.06.05.11.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 11:35:05 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------unCYmNGhfIiiR1gvAplwSeKQ"
Message-ID: <1f862dbf-0f25-493c-a94c-0ef42531f8ec@cs.unc.edu>
Date: Wed, 5 Jun 2024 14:35:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Convert 'info tlb' to use generic iterator
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
 <20240524170748.1842030-3-porter@cs.unc.edu> <ZlncNh_GHoEfXMPB@gallifrey>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <ZlncNh_GHoEfXMPB@gallifrey>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------unCYmNGhfIiiR1gvAplwSeKQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/31/24 10:18, Dr. David Alan Gilbert wrote:
> * Don Porter (porter@cs.unc.edu) wrote:
>> Signed-off-by: Don Porter<porter@cs.unc.edu>
> If this changes the output of 'info tlb' could you add a before/after
> to the commit message please.

Thanks for the advice.  It should not change the output of info tlb.

> Also, have a look at glib's g_printf and friends, you might find they're
> easier;
> https://www.manpagez.com/html/glib/glib-2.52.3/glib-String-Utility-Functions.php#g-printf

Thanks for this tip too!  It isn't clear to me that converting will 
substantially simplify
the patch at this point, but I'm open to it if I'm missing something or 
this is the preferred
project style.

-Don
--------------unCYmNGhfIiiR1gvAplwSeKQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/31/24 10:18, Dr. David Alan
      Gilbert wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZlncNh_GHoEfXMPB@gallifrey">
      <pre class="moz-quote-pre" wrap="">* Don Porter (<a class="moz-txt-link-abbreviated" href="mailto:porter@cs.unc.edu">porter@cs.unc.edu</a>) wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Don Porter <a class="moz-txt-link-rfc2396E" href="mailto:porter@cs.unc.edu">&lt;porter@cs.unc.edu&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If this changes the output of 'info tlb' could you add a before/after
to the commit message please.</pre>
    </blockquote>
    <p>Thanks for the advice.  It should not change the output of info
      tlb.<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:ZlncNh_GHoEfXMPB@gallifrey">
      <pre class="moz-quote-pre" wrap="">
Also, have a look at glib's g_printf and friends, you might find they're
easier;
<a class="moz-txt-link-freetext" href="https://www.manpagez.com/html/glib/glib-2.52.3/glib-String-Utility-Functions.php#g-printf">https://www.manpagez.com/html/glib/glib-2.52.3/glib-String-Utility-Functions.php#g-printf</a></pre>
    </blockquote>
    <p>Thanks for this tip too!  It isn't clear to me that converting
      will substantially simplify <br>
      the patch at this point, but I'm open to it if I'm missing
      something or this is the preferred <br>
      project style.<br>
    </p>
    -Don<br>
  </body>
</html>

--------------unCYmNGhfIiiR1gvAplwSeKQ--


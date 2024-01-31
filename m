Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3A4C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBkg-0005Q9-MF; Wed, 31 Jan 2024 09:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVBkd-0005Pg-AS
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:39:43 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rVBka-0006Rm-2U
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:39:41 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-214c940145bso2641111fac.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 06:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706711978; x=1707316778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5aaFoAo6yHIEQXEMEH+9qzGfghoVpdZE0vIfZZ7ypDk=;
 b=WqI7lCohLbRVxC5yA/30FegQMEQs1H3yXeHFS53s2Gem6F7T6dXWdTHKlRr/nztw7/
 nAhJKeAdPFYY5F7y/bKSBcW3kLWSn/heWM04/lLh8VcsksFlexlKZ2A98OB4Xmzbkas3
 Z4iCiGdTM0jtdQcF+HLKcuwjjj5u/ZGPQFO/7POh5lXsoB4j7QHBrnjZOziEW5aZtyMU
 rPGzyKbGJPdfeCTFRo8gEJ76tVhs4CMicfReA1HRAgEANsc2Yy6bnPnrPFz/75scPZUq
 zJC4pPH/LbikiP7sGpBeM00v5C9k79KbvoS6i8HZ34XA6btCTfKz6VyBv8K/J0LfuNB2
 yjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706711978; x=1707316778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aaFoAo6yHIEQXEMEH+9qzGfghoVpdZE0vIfZZ7ypDk=;
 b=wLyk31Vj4/s4trFfGOofVUUeLa0KHoFJe77Zw3CMaaapBLRsihqDB+DcEYSeEFwqlG
 0Y1iMVkEl1cRPIWg03Oo62WF1fEwnYlPfunylXsQvAfJnHyrYs/AYZMYocMi9lLzX79i
 7z+22kj7YrZJ5yOWatqcUjUPfZjewIs67QwwT3OotijW06JZbiVV2PhvkY5LA/NJS/3O
 Nhm32KvZkUPDDBME0xnASzRy2un1ga9zANTSVAeUcDwmppruy4ocC87nic8YYm102v6F
 9AP8dm3ZHHfqZlQ7POIj0o5bhTL4z73j9fBxvO5aEWIRIITl3l3L7wnqm8R2JvHGdNQ9
 yguA==
X-Gm-Message-State: AOJu0YzKnRq1vLTare8qomDGZLnjuBLw/a9jETE7o7QWf5hj162bfGbl
 af+puAeURhK5ZD7cBn+tppeHdOblPey8SP1tYe6pu/F70ZimMkvmmcLcoOcJa7/S15iDhQOJGoq
 Imnkav4+AStbzh6ODoWP6cIG684k=
X-Google-Smtp-Source: AGHT+IFElWLLXQwef+7+fERmu7M4ME7jfoUL9BSEfQuPDKqElQIyuSJN5FKJdmp4ApM6HgZX0Ll8uj+vLtevJufb5Gg=
X-Received: by 2002:a05:6870:6e12:b0:214:fd96:486c with SMTP id
 qt18-20020a0568706e1200b00214fd96486cmr2051195oab.9.1706711977915; Wed, 31
 Jan 2024 06:39:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QX9TQ-=PD7apOamXvGW29VwJPfVNN2X5BsFLFoP2g6USg@mail.gmail.com>
 <mhng-bcb98ddd-c9a7-4bb9-b180-bf310a289eeb@palmer-ri-x1c9a>
In-Reply-To: <mhng-bcb98ddd-c9a7-4bb9-b180-bf310a289eeb@palmer-ri-x1c9a>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 31 Jan 2024 09:39:25 -0500
Message-ID: <CAJSP0QWE8P-GTNmFPbHvvDLstBZgTZA7sFg0qz4u28kUFiCAHg@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, dbarboza@ventanamicro.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com, 
 alex.bennee@linaro.org, eperezma@redhat.com, gmaglione@redhat.com, 
 marcandre.lureau@redhat.com, rjones@redhat.com, sgarzare@redhat.com, 
 imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com, thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com, 
 shentey@gmail.com, npiggin@gmail.com, seanjc@google.com, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
> might have some tricky parts.  That said it's tripping some people up
> and as far as I know nobody's started looking at it, so I figrued I'd
> write something up.

Hi Palmer,
Your idea has been added:
https://wiki.qemu.org/Google_Summer_of_Code_2024#RISC-V_Vector_TCG_Frontend_Optimization

I added links to the vector extension specification and the RISC-V TCG
frontend source code.

Please add concrete tasks (e.g. specific optimizations the intern
should implement and benchmark) by Feb 21st. Thank you!

Stefan


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601051093194
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VxU-0002Iu-Tj; Fri, 20 Mar 2026 05:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3VxQ-0002Hm-8u
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:15:52 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3VxM-0004Ll-OR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:15:51 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad79df972so402928d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998147; cv=none;
 d=google.com; s=arc-20240605;
 b=KPJWuAKalGi2HOHEc2HqRC5JBS86sZczfCoqeKsoasQcKM0gcbols9HtHAaaS5Al4V
 uphJWgkY7B+2F435QoJdGaTEyfqazLgdmnGanVE6EWx4/nAcjsecn4Ca+qpY3sxd7lzr
 m8+/XfEkRk/oSh1PVoIQC115WHEPtqo3wTj12ggkStD+bNirz2bOJQnlJNn01oLP7whc
 d5v0PsAyGo965XzJ3lAzjEaqrXIOA/6RpSr6xe7UJpv+337Bn7Nzcje26RKzX/bAdzpS
 mh0OfYzHMDVJwWUBMsobmIUKqPRX0O2Ag/+3XT/8MCrV9XKwpseZQpZk1Mj9zfzaCy21
 EhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xvbAbu4dMgvGESlCuQajDMiqKKtL32Q9bNx4dGp3Nfk=;
 fh=yaPhCEGMlhygzfDlJVQjjEjsgyPTl6YFrOz2KD4bLYA=;
 b=bPAxVNrGaBGG1gsgut5rQcWRalTIRg2DajQKuUwhJapOL59sgCAivWIGBp9fKUBGqW
 Z/uwG6cG8qtdNdDbz7kq/0n3RqzrZTWYvSL/8izTIHc+sfClQyk/JHqmvMKqrDqnQgLv
 9EEfkNWR/ujhbQigqmSZFZNPTXr022UewXaF914vmJucKl0OYSBWJmVpjxV8VMwbM8KP
 yPaJL+/dY+i7ac4tA1nKHYyhHLHdehbjd+/gpvx1DJsvgFSzGhugoai5v4KZTAH1YKH2
 dnZmVc7m+n79/YhwNpx4m9YfW8Y6kPg/xfz0Hxf1wjfTCjccFmI+gPXHpdFRXU6hvJdd
 +PLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773998147; x=1774602947; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xvbAbu4dMgvGESlCuQajDMiqKKtL32Q9bNx4dGp3Nfk=;
 b=B0XubGYh3jCz2LqywfONlu1rFNxlQhd2hfAPurHlX/eXrlutLH/Zsepaf6zbQMtEqi
 ubxOijU1Ifw9t7cngcqgqAys1s23//vG2RhE7qxy8yRyk7DhBZRg5QkNjqse1NV2S/Fv
 lBNrZLgTp4Y5Kke8OH9y8LZ8lnEMNyRHcnxADQR4VTKa8ZmX9xqdYqBswSciYY+5TXQ1
 4t11E3GtbExurOT0D8pte1dihYKZIKWgeRvxnp1J2LBnpWy9XrGs8PmJuxtk76PHNroR
 h51hPWqb7Ff96UyfOCHHDV9/jsh9tQq9yj/YFItX7JRGLWVWL7H6PwvbOC1Ucc1T2kSW
 j7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773998147; x=1774602947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvbAbu4dMgvGESlCuQajDMiqKKtL32Q9bNx4dGp3Nfk=;
 b=sPuVORCDtEYQF+S3htG7uzKgHLe9LgPTsfW0m1cXDXsslgKIq+bz30aDRMdsQM2mq/
 wnL9tQsNfjw0jbWDGRtWq9lsZhzxoIg2ykmV10JlM+gAGePPqPPlMlC283Q1464+onL7
 UTYWeOclrZTl6ge3OxLaLt71Uj/p/QdlUYHzAKAjr4Ai3KNraLBraz7/MVYnCJ6cNdAC
 3CGQLqYGI1sEDyqiqtGujXZO5GPr5V71ukGVzjy6y0Nriy3IiJ1OqhcGXkHSjL4GaWHP
 3ICOehUTqFvSJzaO42X93B+4OmRjSclQOCqMo58MzfdUXicuKzNU6sTkGUVLFl137qqJ
 +cMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZseTsac01fGcnWR42sA0s7G3W0u77L327aCkrhy3qlrIiFpoP+Aeb5REG2WfrpyfEJEHSvaV/hb5I@nongnu.org
X-Gm-Message-State: AOJu0YzePLLgkKxf+yZRg+yNWpEn5dKFSzDjrHSM/eC8XIruvrmGQ9uj
 HKibCKEsd7kC9yg/I3CGggoA5AtnofC0LsdxmxQjjiAwSdnN0YyPGLcdncyOUwYjtQRslTG2e3N
 3WGd/eUZEB7J9X63CfShXNbNRjYgQjvda7ZRX/0ZDMA==
X-Gm-Gg: ATEYQzxsDjfkA6QWM+/T9z7rcKKA0GI2ytjx3bkKrvIk/PGxLUilRHgiWtf0OL8IDWE
 D00hxpKoVrvFtC3bKq9Vyb8w/1IuoB2R8ehowHTw3aGNXsoZDvbI9QH6aN54I58q8a9bzm2YMek
 +BB8u94MWxbHRaDeZqLzhsTrk5anHVOQV1BgA5y0ZUzZjMAphYmPg1nn1mL5HnDQaWoOjEzJRP+
 F94alGiqlxugpDvfYsTQ37Qck2uc8ztY8ILlK4YvTQTTBMrlEgKRRYeLJGFuL6/xA7cq+FdlQel
 T31FPC1vqSyIV0aJOVW8BRC38gjMRJ4yNEFklvHmt3DZvfayrdlwaq3b67PiYpvDP6g=
X-Received: by 2002:a53:d786:0:b0:649:e546:62e2 with SMTP id
 956f58d0204a3-64eaa7b630cmr1712151d50.44.1773998147305; Fri, 20 Mar 2026
 02:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260319183453.100545-1-sw@weilnetz.de>
In-Reply-To: <20260319183453.100545-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 09:15:35 +0000
X-Gm-Features: AaiRm52Fvg_cJmMP4ysqAEFDoenflm5VgYoBeXreXaBQdPTgtKQsso7DZjlREB8
Message-ID: <CAFEAcA8dzqPVUyt-bC4r8QxZtJ6dBacgeMG71JEsCsUoGgDsSg@mail.gmail.com>
Subject: Re: [PATCH for-11.0] Fix several typos in documentation (found by
 codespell)
To: Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 19 Mar 2026 at 18:34, Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>
> These typos are part of the generated documentation.
> Therefore they should be fixed in the new release.
>
> More typos can be found in the remaining code, mostly in comments.


> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f8d446b3d6..e8adaaea34 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

> @@ -5086,14 +5086,14 @@
>  ##
>  # @blockdev-set-active:
>  #
> -# Activate or inactivate a block device.  Use this to manage the
> +# Activate or deactivate a block device.  Use this to manage the
>  # handover of block devices on migration with qemu-storage-daemon.
>  #
>  # Activating a node automatically activates all of its child nodes
>  # first.  Inactivating a node automatically inactivates any of its

We should also change these to "Deactivating" and "deactivates"
for consistency.

>  # child nodes that are not in use by a still active node.
>  #
> -# @node-name: Name of the graph node to activate or inactivate.  By
> +# @node-name: Name of the graph node to activate or deactivate.  By
>  #     default, all nodes are affected by the operation.
>  #
>  # @active: true if the nodes should be active when the command returns



>      ``param=string``
>           ``string`` will be passed to passt has a command line parameter,

should this be "as a command line parameter" ?

> -         we can have multiple occurences of the ``param`` parameter to
> +         we can have multiple occurrences of the ``param`` parameter to
>           pass multiple parameters to passt.
>
>           For instance, to pass ``--trace --log=trace.log``:
> --

thanks
-- PMM


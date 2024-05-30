Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BC6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfFr-0005zn-5j; Thu, 30 May 2024 08:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfFq-0005zL-3d
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:51:38 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfFo-0002mX-Ba
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:51:37 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1e980a65so610719a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717073494; x=1717678294; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nnOHjmYX6Ks0FpmKsyShork4/Y+gyj7KOYpHL5jDHAk=;
 b=cEV+fEHC2Np1/3iE8r2wjKyFRkFQqFWwJ2rnpe1IQp4X7I/ZVAqvPvjtViIf1lNh8Q
 t4Gbgz0cwX3BtcQFjKWk0k+jxx159QEgR8lUB7b023YgOM+2MwCmHE82SR0t+aAxO9Og
 UsmaVFQoiUXXYZI1MhSDM+QUXp9p6VO52RtTZQyYr9Sr+oTW7b2TQusVoxWS+WnpSSbq
 2/RQu0RbRYVTVjkuAQPXOwCBDpS6ltTdrYFHRSy16GwUqeMK+ogQ3kjHj4UYd+TUdw6M
 Rw5eHbMyjSo7TVtVjOA1VQHquVFzALVbJEDEz0Zh5ZVcYoAsZAiSAF5kHGiunhYwEsof
 4PJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073494; x=1717678294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnOHjmYX6Ks0FpmKsyShork4/Y+gyj7KOYpHL5jDHAk=;
 b=WbOQfum2QpmM2V90kqf9LoHWuL9OXduPSMwYY4wwileqS/RcFrDW22TX+tCS/cdKUo
 LuniOLK5aBn9Ukagr7D60YJuzWEQqrShGZc0kg1DhLlIu/XkTWInuLPLesBu6SFmyiwn
 nIlnUEatBVNhDOAsPow2Bd4atBu7YBaDMZ7JR0zsX7XrpibByji6cKkN4psa+W9oewS2
 27DC5ndozl7NyruRgcFS+HTRuYXObLf4Wgemf5jPv8wbkq6K59opGxseL38oZ8p4dM8Z
 5u/vA3qRoHm8EeJbruIVjzCkfD10C2K/YER/AKe4180Y9vsnt0u7NccONLuBs7R2sB7E
 mhHA==
X-Gm-Message-State: AOJu0YxGmPZJo6+O94H67+wDWGkScjizmmAMu/d1ncAmJ94rYQAeAXae
 47byfcjWfXQzJMOhZTBLY8pKMOKUrM33VOx/Y0FfyNAofFDhw3cRXqyE47Ib/7aJZKIVt/KBOTA
 dFBQmD5eregf6nmbB4hufZ9xKPoSmGxNAz1ZCtQ==
X-Google-Smtp-Source: AGHT+IEeZwjCtFzZtyjXQbpNq1JOrcvOM7pbZTCioIvJuzwwIjYmfgxF21O/VstT002KykKyft9JEUjDNGVgKHeT+Gc=
X-Received: by 2002:a50:c04b:0:b0:57a:206e:54cc with SMTP id
 4fb4d7f45d1cf-57a206e56c4mr1111807a12.42.1717073494442; Thu, 30 May 2024
 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-6-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:51:23 +0100
Message-ID: <CAFEAcA83_tyi+mwffuM18LSiUjXksgyO7P-oyZrAo8Bup6ZJGg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 05/13] risugen: Be explicit about print
 destinations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Printing directly to STDOUT and STDERR will allow the
> print destination to be selected elsewhere.

i.e. using 'select' to set the default filehandle for "print"?
My instinct is to suspect that would be a bit confusing compared
to passing in an explicit filehandle for whatever it is that we'd
like to be able to print to other destinations.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risugen_common.pm | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/risugen_common.pm b/risugen_common.pm
> index 71ee996..5207c0e 100644
> --- a/risugen_common.pm
> +++ b/risugen_common.pm
> @@ -76,7 +76,7 @@ sub progress_start($$)
>      ($proglen, $progmax) = @_;
>      $proglen -= 2; # allow for [] chars
>      $| = 1;        # disable buffering so we can see the meter...
> -    print "[" . " " x $proglen . "]\r";
> +    print STDOUT "[" . " " x $proglen . "]\r";
>      $lastprog = 0;
>  }
>
> @@ -87,13 +87,13 @@ sub progress_update($)
>      my $barlen = int($proglen * $done / $progmax);
>      if ($barlen != $lastprog) {
>          $lastprog = $barlen;
> -        print "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
> +        print STDOUT "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
>      }
>  }
>
>  sub progress_end()
>  {
> -    print "[" . "-" x $proglen . "]\n";
> +    print STDOUT "[" . "-" x $proglen . "]\n";
>      $| = 0;
>  }

These are the progress-bar indicators -- shouldn't they go to STDERR,
not STDOUT, if we're going to be careful about where we send output?

> @@ -163,20 +163,20 @@ sub dump_insn_details($$)
>  {
>      # Dump the instruction details for one insn
>      my ($insn, $rec) = @_;
> -    print "insn $insn: ";
> +    print STDOUT "insn $insn: ";
>      my $insnwidth = $rec->{width};
>      my $fixedbits = $rec->{fixedbits};
>      my $fixedbitmask = $rec->{fixedbitmask};
>      my $constraint = $rec->{blocks}{"constraints"};
> -    print sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
> +    print STDOUT sprintf(" insnwidth %d fixedbits %08x mask %08x ", $insnwidth, $fixedbits, $fixedbitmask);
>      if (defined $constraint) {
> -        print "constraint $constraint ";
> +        print STDOUT "constraint $constraint ";
>      }
>      for my $tuple (@{ $rec->{fields} }) {
>          my ($var, $pos, $mask) = @$tuple;
> -        print "($var, $pos, " . sprintf("%08x", $mask) . ") ";
> +        print STDOUT "($var, $pos, " . sprintf("%08x", $mask) . ") ";
>      }
> -    print "\n";
> +    print STDOUT "\n";
>  }

As a debug-print helper routine maybe this should be STDERR too?

thanks
-- PMM


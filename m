Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2824CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUOz6-0001RA-FU; Tue, 02 Jun 2026 09:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wUOyq-0001Pw-1z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:16:41 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wUOyo-0005zG-FD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 09:16:27 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-137bd9ed2b1so218043c88.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780406184; x=1781010984; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=midalEksGCotZz6tug4q9vOoYlUZpRvvMwbzAJGb6lI=;
 b=cAfE0ijgnPPn1LV1UWWzstGSEp5KTzZ5Tdr0277jhFhtJI5P0owcm6B8lxMz68t1ln
 BvrgUNn+r4kaQ6uJX6o6XirMeD70T13Ci+GfesLir4QWOfS9Je6vF6omX0y85vWm4P97
 z3yAa7CPUP8/nYdegJeZeZj+2WfMHbQPJwlmT/09eOAJc34r71dBMD8E+R5NspoAgTs2
 A5VW3vHVFEcAVlWAQSmcxD6LF//A7qsRZexcbwm/XKwDF6lE0mxr5epUnyukiR/1y/R+
 2vQUL810jWvzlkK/vAJp3D3MaTwlw7578ZrzYuhGxUPSQHQIXtcdwNFlYwYdFBm0hVyz
 D1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780406184; x=1781010984;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=midalEksGCotZz6tug4q9vOoYlUZpRvvMwbzAJGb6lI=;
 b=BvMcZ1i27dq5qyiVCHRwOq/78vTonzY2Ji7D9taBKsTl4jpBtRDme4dwko1u4i8L7q
 9xTTuQW0I9mJ+0FA/UV0PRYMkOVftDFmAX5iIVp5k4jkA//RJbPKCjYPBgKrhEQr+6mK
 9rMRg18ByRbspsyXBNqOK5dU5N5nsvUpgDLOq38Gyvu77bb8JJEkFxQvZGa0dE2o58XY
 yNak4jMqe0jPB7NbEZzAqyvxYvTEWb4h8qjTRMxl10sQtyS02X/yXPm4JHilxSote1Wn
 EAi3Fq+vjFhL8KCyN+5bWldCFLXEcwRjK3d+gVSgHgs9vSIXFaC2pAEfJtFuvKNRHBwA
 KwEg==
X-Gm-Message-State: AOJu0Yww+OgH8OXZbGnZ5CkoZOQpRl0z+uSnVVIk8zsy/TrowX7Zq6Z2
 fG5wP5X4FGfkT4cWQOobJ5THxU65x2ELX06defefxamgj/mp7iv+aEoM
X-Gm-Gg: Acq92OFXEvxg9VYTfqHIbKQXVgVjU6UjzRz9HB13yS/76ExOAICL75Wx6+A3ZCKAN/f
 +tj/ZEafBUMiRwZZkKwJvuM5kt5rxgCdLLNna73OvfPYD7X0kultgPfA5Fa1kq7sXK14m45h/Ba
 uVX8Z54nCfrsrEIxLvLALv5o6JiJ0J59Twq+O4i+YGupnfUG3eqVtKD4GLFnHTvkfVcLtTZMkuH
 VdkcGh1cdanL36pLZwJNTjQ2kqBI74L1yFVvCeQFmbeKMB76xmGEd5GuqfDfM9F2vKfeKpBPKK4
 NbcPg3gpsnuYUM5IUDoJBNnyLy5FTjtzlzIB6TcAr85TgNYLpbfAXwtxJq+QTveN6H5lEYuz1DG
 6u4f3N1NdhoDFTuef5gkx2luLzVktl0ytqz8RGASdJ+x/BBYODM0fTRfx66j/WLflaOXOjC9K/H
 zuV+u72QGQEL+u/YU/KmEjD0CXknhEaVnvCFPLBzDr+4W+JwjVek+7XIpJ6CPJR71iK+cshg==
X-Received: by 2002:a05:7022:e982:b0:12d:de3e:cbfe with SMTP id
 a92af1059eb24-137d4280b1emr6837248c88.37.1780406183886; 
 Tue, 02 Jun 2026 06:16:23 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36c6eabsm9131399c88.7.2026.06.02.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 06:16:23 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:16:20 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] checkpatch: calculate UTF-8 characters correctly
Message-ID: <ah7TydWv9e9hRNFO@ChaodeMacBook-Pro.local>
References: <20260601171008.159147-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601171008.159147-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 01, 2026 at 08:10:08PM +0800, Vladimir Sementsov-Ogievskiy wrote:
> We do check UTF-8 correctness in checkpatch.pl (search for "patch and
> commit message should be encoded in UTF-8"), but we count bytes, not
> symbols when limiting line-length. Let's be consistent.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/checkpatch.pl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2189db19f54..711539bdd7c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7,6 +7,7 @@
>  
>  use strict;
>  use warnings;
> +use Encode qw(decode);
>  use Term::ANSIColor qw(:constants);
>  
>  my $P = $0;
> @@ -596,7 +597,11 @@ sub line_stats {
>  	# Pick the indent from the front of the line.
>  	my ($white) = ($line =~ /^(\s*)/);
line_stats() still expands tabs before decoding UTF-8, so tab stops are
computed from UTF-8 bytes rather than decoded characters. 

For example, `é<TAB>X` is counted as length 8 with the current order, but
length 9 if decoded before tab expansion. This is mostly hidden for C
files because tabs are rejected, but `.s`/`.S` files may contain tabs.

Since this patch aims to make `line_stats()` use character semantics, it
should decode before expanding tabs, or make `expand_tabs()` operate on a
decoded string.

You could implement it like this:

```
   @@ -588,8 +589,9 @@ sub line_stats {
    sub line_stats {
       my ($line) = @_;

   -   # Drop the diff line leader and expand tabs
   +   # Drop the diff line leader, decode UTF-8, and expand tabs.
       $line =~ s/^.//;
   +   $line = decode('UTF-8', $line, Encode::FB_DEFAULT);
       $line = expand_tabs($line);

       # Pick the indent from the front of the line.
```
>  
> -	return (length($line), length($white));
With that change, the original `return (length($line), length($white));`
can be kept; the extra `decode()` calls and new return below are not needed.

Thanks,
Chao

> +	# Use character count (not byte count) so multi-byte UTF-8 characters
> +	# are counted as single characters.
> +	my $line_chars  = length(decode('UTF-8', $line,  Encode::FB_DEFAULT));
> +	my $white_chars = length(decode('UTF-8', $white, Encode::FB_DEFAULT));
> +	return ($line_chars, $white_chars);
>  }
>  
>  my $sanitise_quote = '';
> -- 
> 2.52.0
> 


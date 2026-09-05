Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE1AC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 04:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2iSe-0001qY-70; Sat, 05 Sep 2026 00:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2iSa-0001p2-G0
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 00:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2iSY-0001xN-KQ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 00:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788584216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ICY/KHLVUrj4fBQrE39y6DnVReGAdRdVl0IgfUVv1rQ=;
 b=M1XB2omcxiizW9RbbuZm2XHjoHv3BuVbDd6jxOp+pxogIWccGHmY3jlQFkOkbidI27hplU
 LgqNC8MgbHk5hMhupTyMSv3dMt2c4AXiPjhcwRRaPhVtT5RLE/aX+t6dp0GJLZpHpSNm5R
 ddrVRdxSCX+rewB3OxhgJtrtVQz55AY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-atNIOJ8pOq6d42oDcIkTrw-1; Sat, 05 Sep 2026 00:56:54 -0400
X-MC-Unique: atNIOJ8pOq6d42oDcIkTrw-1
X-Mimecast-MFC-AGG-ID: atNIOJ8pOq6d42oDcIkTrw_1788584213
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482e538ad9fso1468111f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788584213; x=1789189013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ICY/KHLVUrj4fBQrE39y6DnVReGAdRdVl0IgfUVv1rQ=;
 b=ox5EiGyig4klrskP8SjvJWuF1KGoiNIvIwKCx82IuTSkEI0YFUI8Uolk72VxL4aS8w
 17TTeu6O7N9FQOCS3bn6Zle9HykS439+wePrMo6Q8DL0O2G2IKxLflnAji+HEWAaiuPj
 CAD7x4Ctq7BFr3jWkDbesF9+5fy20nq++bQXZfmvjH8OFDhz4H0NpHkkZ7MGl2oDnWEV
 yeMw4MEVqWJ/UyBp2dk5qaxXeDFJm/XbcV0vlEIaxg5kONGUusIxKr3eNUwgnp9xWfNi
 r5g8Al2BM0UMusneGtT6/PeHXhGE29Wy+u2NJB/YZOzZzmJg37l2EB8qFHwIeytV11V5
 jHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788584213; x=1789189013;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ICY/KHLVUrj4fBQrE39y6DnVReGAdRdVl0IgfUVv1rQ=;
 b=G5XPL293X4VapOeD15ZAbBSL3lBuucWsEGt6zgIorstR4xCTtIJ7bDuZC3bPfwb8/C
 riODZV7mCc/rh+5tDIB/g1GeNYHjOm7EuTfx0nwe+6VlbfgY0oR5p+iXrvqrTzU5AuAa
 J8XkkWxx+0mk2eYXWTRlQ2OLgV2SGJC+1o2ZZHjBsrtCwGVSJHOPml/FtxunXd4wnyt8
 lCDGbg2Z2FMUmLT7E3TJ9rZAzoMiZJxvVEWmH2eyecq3BW3uiazsqOslau5BsUCHwbAz
 km2ksiU92mdV+jintz3AGzDOkJ8XpwzjLv/B9g+LCOzb4vOGkH4QMRjnuAxvxasJZPJ3
 XIEQ==
X-Gm-Message-State: AFuF++mkX6Os4MYUgBwQnBTef1Obvo454r0cah3PFsqf10FzXH1YEP72
 ZUxhKNk2BMfaG779tkljO0wwcYQx/fx9/VQlM+Es2uduowcMdC49gdkiJsEa5tL1VCP6bSjJkXk
 8bBpbt/Yqc/aW0x7gfW9o27utUENJloEmSTBi9SUOQQxjO2AJlk1qH2jnXaXAsOgEwSiQcabLKK
 sY2dzbyTwpBhUGp8sEbWdOzjmU4Ief3z4H2g==
X-Gm-Gg: AYBFou1sGZYxH5J5ruuB19o08Ps/z45XxbyTxiipN8R+YBYnAZSmPVFVT1J82AJf+Tf
 CPZCLM5J6pivlTB9URMt/YPN/a7f31kguaH1qbEK87+6Th/QAF+rVKBxtp9My6n+IKPqAk9qpLD
 N3x2OEjgWOhIx+egGnh2+6mLsqjTy8MEqxL/XD0GA8tjX0IIVYTqDDnKaC3y21o3t8FWDxdvVW+
 XRxdb33l/tLwBKvwY4dRtWR9xqmfvzasDgVuhlaPQqWpfFMdxeNjPtaf96RPbZi4e21mJ2aNFyy
 QXKZhhBS8XZRCpVgd1/jktb1Jdf6cu5vxLJ6WZFraFjp+Pxk4eXCU2gtxasAJ/sp5LysKNVM6rh
 VOQjtA6UCcUoTYnCGKIcRjVvXAh4KUzRxeNTvmdPQaUJNE3agrGBRrb6XDG0zr1Aj5rhWBpGDz8
 VfsvNKbAJXonpz3H2dPX4WgUmU3hER
X-Received: by 2002:a05:6000:24c8:b0:485:8c16:a33e with SMTP id
 ffacd0b85a97d-4858c16a715mr7847488f8f.51.1788584213323; 
 Fri, 04 Sep 2026 21:56:53 -0700 (PDT)
X-Received: by 2002:a05:6000:24c8:b0:485:8c16:a33e with SMTP id
 ffacd0b85a97d-4858c16a715mr7847469f8f.51.1788584212887; 
 Fri, 04 Sep 2026 21:56:52 -0700 (PDT)
Received: from ?IPV6:2a01:cb06:c059:ed21:e577:db2a:8fd7:fd5f?
 (2a01cb06c059ed21e577db2a8fd7fd5f.ipv6.abo.wanadoo.fr.
 [2a01:cb06:c059:ed21:e577:db2a:8fd7:fd5f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm10354913f8f.26.2026.09.04.21.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 21:56:51 -0700 (PDT)
Message-ID: <2bdc4c21-0f9f-4bb6-bec1-d44a6f6f1356@redhat.com>
Date: Sat, 5 Sep 2026 06:56:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scripts/checkpatch: validate Fixes: tag format and
 commit ancestry
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chao Liu <chao.liu@processmission.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260806171333.328864-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260806171333.328864-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Paolo, Marc-André fro possible Reviews,

Thanks,

C.

On 8/6/26 19:13, Cédric Le Goater wrote:
> Adapt the kernel's checkpatch Fixes: tag validation for QEMU.
> 
> Add a git_commit_info() helper to resolve commit hashes and validate
> the Fixes: tag in commit messages. The canonical form is:
> 
>    Fixes: <12+ chars of sha1> ("<title line>")
> 
> The check validates capitalization, spacing, hash length, lowercase
> hex, and quoted title. When the format is wrong and the commit can
> be resolved, suggest the corrected Fixes: line.
> 
> When running inside a git repository, also verify that the referenced
> commit is an ancestor of master.
> 
> Lines matching "Fixes: CVE-*" are skipped. The check can be disabled
> with --no-fixes-tag.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Changes in v4:
>   - Added chomp to fix false positives
>   
>   Changes in v3:
>   - Dropped $git_command
>   - Modified git_commit_info() to use $! instead of parsing stderr when
>     calling git log
>   
>   Changes in v2:
>   - Introduced $git_command
> 
>   scripts/checkpatch.pl | 66 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012c8c7a00b67f036e4befb2ea162d4a..d9efade05386b3fb7647097cfe3b1256d7f24dda 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -21,6 +21,7 @@ use Getopt::Long qw(:config no_auto_abbrev);
>   my $quiet = 0;
>   my $tree = 1;
>   my $chk_signoff = 1;
> +my $chk_fixes_tag = 1;
>   my $chk_patch = undef;
>   my $chk_branch = undef;
>   my $tst_only;
> @@ -54,6 +55,7 @@ Options:
>     -q, --quiet                quiet
>     --no-tree                  run without a qemu tree
>     --no-signoff               do not check for 'Signed-off-by' line
> +  --no-fixes-tag             do not check for 'Fixes:' tag
>     --patch                    treat FILE as patchfile
>     --branch                   treat args as GIT revision list
>     --emacs                    emacs compile window format
> @@ -94,6 +96,7 @@ GetOptions(
>   	'q|quiet+'		=> \$quiet,
>   	'tree!'			=> \$tree,
>   	'signoff!'		=> \$chk_signoff,
> +	'fixes-tag!'		=> \$chk_fixes_tag,
>   	'patch!'		=> \$chk_patch,
>   	'branch!'		=> \$chk_branch,
>   	'emacs!'		=> \$emacs,
> @@ -441,6 +444,10 @@ sub build_types {
>   build_types();
>   
>   $chk_signoff = 0 if ($file);
> +$chk_fixes_tag = 0 if ($file);
> +
> +my $gitroot = $ENV{'GIT_DIR'};
> +$gitroot = ".git" if !defined($gitroot);
>   
>   my @rawlines = ();
>   my @lines = ();
> @@ -561,6 +568,24 @@ sub which {
>   	return "";
>   }
>   
> +sub git_commit_info {
> +	my ($commit, $id, $desc) = @_;
> +
> +	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +	my $output = `git log --no-color --format='%H %s' -1 $commit 2>/dev/null`;
> +	if ($? != 0) {
> +		$id = undef;
> +	} else {
> +		chomp $output;
> +		$output =~ s/^\s*//gm;
> +		$id = substr($output, 0, 12);
> +		$desc = substr($output, 41);
> +	}
> +
> +	return ($id, $desc);
> +}
> +
>   sub expand_tabs {
>   	my ($str) = @_;
>   
> @@ -1811,6 +1836,47 @@ sub process {
>   			}
>   		}
>   
> +# Check Fixes: tag format and commit validity
> +		if ($chk_fixes_tag &&
> +		    $line =~ /^\s*(fixes:?)\s*(?:commit\s*)?([0-9a-f]{5,40})\s*(.*)?/i) {
> +			my $tag = $1;
> +			my $orig_commit = $2;
> +			my $title = $3;
> +
> +			if ($line !~ /^\s*Fixes:\s+CVE/i) {
> +				my $tag_case = not ($tag eq "Fixes:");
> +				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
> +				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
> +				my $id_case = not ($orig_commit !~ /[A-F]/);
> +
> +				my $id = "0123456789ab";
> +				my $description = "commit title";
> +				my $has_quotes = 0;
> +
> +				if (defined $title && $title =~ /^\("(.*?)"\)$/) {
> +					$description = $1 if ($1);
> +					$has_quotes = 1;
> +				} elsif (defined $title && $title =~ /^\(?(.*?)\)?$/) {
> +					$description = $1 if ($1);
> +				}
> +
> +				my ($cid, $ctitle) = git_commit_info($orig_commit, $id, $description);
> +
> +				if (defined($cid) && ($ctitle ne $description || $tag_case || $tag_space || $id_length || $id_case || !$has_quotes)) {
> +					my $fixed = "Fixes: $cid (\"$ctitle\")";
> +					WARN("Please use correct Fixes: style 'Fixes: <12+ chars of sha1> (\"<title line>\")'" .
> +						" - ie: '$fixed'\n" . $herecurr);
> +				}
> +				if (which("git") ne "" && -e "$gitroot") {
> +					my $hash = defined($cid) ? $cid : $orig_commit;
> +					`git merge-base --is-ancestor $hash master 2>/dev/null`;
> +					if ($? != 0) {
> +						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
> +					}
> +				}
> +			}
> +		}
> +
>   # Check SPDX-License-Identifier references a permitted license
>   		if (($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) &&
>   			$rawline !~ /^-/) {



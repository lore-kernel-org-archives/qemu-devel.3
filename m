Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA095C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BNv-0003cq-59; Thu, 03 Sep 2026 13:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2BNt-0003cS-F3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2BNq-0003dO-Hn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788457071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TmSpv9uwkd4gkNINPtyq6IBqLWYG269YI9TH2YlNAsk=;
 b=aps6Na8IWspgOwPkuIZD2kVG9ltgILrJyoYC891nsQscTl8JukzJFsK/91mnkDmMKLeHfP
 R4Go3xm19T51rfKw1NbKN9ANN+xfavY+tkbgLhD5/x28uydkwDgFrvs3nsdhNQhg9dwVHC
 UWOYqrXTC/GjdjfOt4NrRDUtG444Q3M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Mk_3a844O22X5AwtWc8YbQ-1; Thu, 03 Sep 2026 13:37:50 -0400
X-MC-Unique: Mk_3a844O22X5AwtWc8YbQ-1
X-Mimecast-MFC-AGG-ID: Mk_3a844O22X5AwtWc8YbQ_1788457070
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-938153538caso10264085a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788457070; x=1789061870; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmSpv9uwkd4gkNINPtyq6IBqLWYG269YI9TH2YlNAsk=;
 b=iarVGceqrW5344EIsqjsvgo3zOR6m4mhNbTGWYckGD0dgcRwALQ+W8JJbMKG+0IJl8
 vmsb0IXySgfkZVH7nX+LGErZ3u90R1v84ha30+WG/fnoIyoKxWiGy0Xf/yZPwPS3Oy/C
 pqVNmJC6b/r1UDF7GOrfPn6gJFfR2nMnGCNHNuRxvb5+/8rNFbuxdsQoA2DcRGfeW0u4
 16yPLHblBntPWuoGUiOFmquWFX79P50+VCYWxNf+Akc56b1EbURr1EEJZO6cWnNU87Xn
 l/qYr8CUpmGOPUDsgHK26KehdxSQso3o3VX2e/PQHk+++/37eMCp27VRD/r1Cu3ro+zd
 fYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788457070; x=1789061870;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmSpv9uwkd4gkNINPtyq6IBqLWYG269YI9TH2YlNAsk=;
 b=ck8r7ioFrxOXiffSirtQG/9YNDNr8Fx4/5sZKYDZjnasGRXzoFMLy01KQBbWjeI9EG
 Q7P2Yr9mNQW9jv1qCKrFILFO+j6iTd1baFTjfZ0Cn6N1icy6Z7Icdbfmmv+08vmJpJVe
 2lXD6A/i1qSV9OgoRCzvTGxOqDGhETuljr0BPSy3lAS/WK7hSMXnW1h8yR1t+iyn6eM7
 GvFaX4GkNhtIcinEuQWcz/5k1+m3QIPQh3406utAFSnUqGQ0/VZqk60nWBQjVKzJWhg4
 1v0dFIvnF3BmeUo4euMPim5EVZx3x21bdpNe8zGexEL0jaHk5yGN1YoeY0rainmOmo4r
 Y1xg==
X-Gm-Message-State: AFuF++nn6BM+KMjKrPk5ubtOrSDNtDciIiCWCxbKw+RObA52NiNq/6Xw
 3T100/em9hQJdxNnC0eMAQQW9OWPBR+VnhHjjaBXm6Crrrs2/3YOVmsd7PrHthMft4Ssi6OXSqq
 z2CnnftrfbqG7TjW/e3IijUtUb1e3n8ZAgmAjivBKXMzBoVOGj555VSZL80AQuyotr04=
X-Gm-Gg: AYBFou36q8wrcJo4kbPFJofNo9RpN4mVVhaPVYtXa9ZufzLQ7cBDjGkHp7PkB9XVop1
 RWuQlDUVHDSVxWmwSaSkSSEiED2Sfi6lCKhgyBX3gxEjPjYJFohqnvu4XY64rkNF2D396iH9bM2
 6zrLzv1UnmeToJ6w89muq2UMtlxPoowRPYy6k7aVOv3eaCbpAhwniGyFH8ve1uYQz6eTbqCnlvM
 z4bHsAAuk6Wd7AL4Wk2xuIGDZklFU+ywOIZkZspXQKldwAWXtmdXqZNW13u6o2Byr2tAm+L/1F7
 Qn2dXt3GRFZKQ+1oK7x4XLBfxpjwcnU7FJio2/82SmmF0P1O9Z+fwPzEpQVWtPzBTElE7alor+Y
 96Tydd3bzhD8rzposxCbF6eCoVYga26I9qzM03o92o//5SiEEfshsICJkbHM=
X-Received: by 2002:a05:620a:3910:b0:939:5fdb:4593 with SMTP id
 af79cd13be357-9398049167fmr4415685a.40.1788457064771; 
 Thu, 03 Sep 2026 10:37:44 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:939:5fdb:4593 with SMTP id
 af79cd13be357-9398049167fmr4408085a.40.1788457064185; 
 Thu, 03 Sep 2026 10:37:44 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb93ea5sm15248485a.34.2026.09.03.10.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:37:43 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:37:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
Message-ID: <apmwZbSLZ46yvGmT@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
> Using newlines in the g_test_message is fine. It automatically adds
> the '#' required by the TAP protocol to the start of each line.

IIUC we have such check not because TAP, but because all these functions
will append one newline at the end, hence it's not needed.  IOW, if it
applies to g_test_message(), I don't see why it doesn't apply to the rest.
But maybe there're other reasons?

To make it simpler, maybe we just call a few times g_test_message()?

> 
> Relax the regex for this function, but still forbid a trailing newline
> because it's added automatically and usually not what the user wants.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  scripts/checkpatch.pl | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012..fd4534b3a1e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3303,13 +3303,20 @@ sub process {
>  					 info_vreport|
>  					 error_report|
>  					 warn_report|
> -					 info_report|
> -					 g_test_message}x;
> +					 info_report}x;
>  
>  		if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
>  			ERROR("Error messages should not contain newlines\n" . $herecurr);
>  		}
>  
> +		# No newlines at the end
> +		my $trail_newline_error_funcs = qr{g_test_message}x;
> +
> +		if ($rawline =~ /\b(?:$trail_newline_error_funcs)\(.*\".*\\n\"/) {
> +		    ERROR("Error messages should not contain trailing " .
> +			  "newlines\n" . $herecurr);
> +		}
> +
>  		# Continue checking for error messages that contains newlines.
>  		# This check handles cases where string literals are spread
>  		# over multiple lines.
> -- 
> 2.53.0
> 

-- 
Peter Xu



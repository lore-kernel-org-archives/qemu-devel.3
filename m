Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968C7C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulraO-0007Jj-7h; Tue, 12 Aug 2025 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulraJ-0007J1-GU
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulra9-0000qi-GR
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 12:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755015028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wXAEwvZZeH7scqiHIpNbw4AJCYmwzSokFT1MH2U1Qg=;
 b=Doi4zg7Tu1DOSzz1ZQkckprQFqmp2v/mEybMR+cyXJiBw1VI2MXkn22ULgW0h13GsJ6XlS
 E37tjQlESjQHGx5YFWMANtIB404R3DmIHNtxNoBXU9qwjtLVffDCDpdYN1xfQcgsh8kmOW
 e0a8cCS2KefwCZ8xDIZTDxbbIKz2VaI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-S-p-wT5VMfuGDto64mpD_A-1; Tue, 12 Aug 2025 12:10:25 -0400
X-MC-Unique: S-p-wT5VMfuGDto64mpD_A-1
X-Mimecast-MFC-AGG-ID: S-p-wT5VMfuGDto64mpD_A_1755015025
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e84d132874so660567785a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 09:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755015025; x=1755619825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wXAEwvZZeH7scqiHIpNbw4AJCYmwzSokFT1MH2U1Qg=;
 b=m6EhJgTEW/chfggPRuBlKnE4xx1nAp2zmCota9vSRj5CS+4A14wBM6vWyX7pgZuwak
 BH6hce7CDJ/xJ5vQtKFHEHsXhoP9me+0WixWi6GGO/q4euyObdyhEN1l/vvnYBSwNMhU
 uy0aKyl6i/lKEvhqrxCkmAgcojDkaMf5KrSEMBytWKDF7U3vro+qi9DJAALh+FGNAFu/
 Opa/ohxVxbOCV/FbSxv5uTAYK6G5yws/a469rDKlkoywchJoPayrPAROteoczzu7T2y/
 cs3ex7t1y2/fuPerI5BpxJugL1f0lMSu8YpsZhUPEsHEwnYgoCYP6IIvMimpj4jmJis0
 XRZw==
X-Gm-Message-State: AOJu0YynLGPQnMZ1mlAXOAjT36w88ItgDIgiflZ9/XH0o0BBExMnsJrk
 RqsEnL7/7kY09rfH7d4WmhmpFM9xWTHjTu6g/A8QvFVDmY8/BgFKVnBJAigEVFQz+b3B8iKEVfL
 FmDnOmHy0Xqn8T4hIFYq6WoPaL6Fa4GZWL+xmxWmJASgLhFITeOk0w/+i
X-Gm-Gg: ASbGnctuB325hXazT+xkgorXkFaQSZye8GlxDpvnr6QlxhApHxhp857b/gebgXRyGqn
 XHgL4p+QgLqL+vqC7mulwP42ZHlslnjaSRPonniOcdv4yZpf9DaYPbgAQtHERNJ/ATHZmTjADeD
 teMvbCIo3qV4hH6Ijvtq8OaRErSzRNvebn/+csoMXEhGPNbrYaDjCwpCmjbuF7jQorjkvP000Nq
 tzCb0YO7q3onmLpv9MgZOdty2nZpiCfXWQrh+1YIIYw4QyyOu/M9TWH24epBvMIEiuDc8hyvsnP
 GAGFEMC2ytK5ZIV2Ti6VDzaXpB0ylZxmgtH6fXDGEeaQoB6njOlRG6OxABzNmRmj6/wT7ghZ6em
 O3yHvkTzZZ/JSUpJgGlJSgw==
X-Received: by 2002:a05:620a:aa16:b0:7e8:2226:5e82 with SMTP id
 af79cd13be357-7e864636fbfmr32304185a.57.1755015024619; 
 Tue, 12 Aug 2025 09:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZbM3OQAM2E1FiTv/a1EQs9KkGvK8Xy+SkgHrqcGaunvQ8dbqRK4DjT9QNCeA6H/33YTHXg==
X-Received: by 2002:a05:620a:aa16:b0:7e8:2226:5e82 with SMTP id
 af79cd13be357-7e864636fbfmr32298485a.57.1755015024008; 
 Tue, 12 Aug 2025 09:10:24 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e8079cfcfesm1266559585a.35.2025.08.12.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:10:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:10:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com,
 Stafford Horne <shorne@gmail.com>, richard.henderson@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 06/10] introduce cpu_test_interrupt() that will
 replace open coded checks
Message-ID: <aJtnbZfBHcO9yhrK@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-7-imammedo@redhat.com>
 <aJoa35wuexHfoCEE@x1.local> <20250812170035.609ce5c1@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812170035.609ce5c1@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 12, 2025 at 05:00:35PM +0200, Igor Mammedov wrote:
> > Do they better as well be converted to use store_release too?
> 
> alternatively, for consistency sake we can add a helper to set interrupt
> with store_release included and do a blanket tree wide change like with
> cpu_test_interrupt().

Yep, that sounds like the simplest. Unless there's any concern on possible
performance regressions due to the rest conversions on store_release, those
can be special treated with open-code, tagged with reasoning as comment.

>  
> > The other nitpick is this patch introduces the reader helper but without
> > using it.
> > 
> > It can be squashed into the other patch where the reader helper will be
> > applied tree-wide.  IMHO that would be better explaining the helper on its
> > own.
> 
> I can merge it with 7/10 that adds 1st user for the helper in kvm/i386 code.
> That has less chances for the store/acquire change to be drowned in
> tree wide patch (9/10)

For mem barrier changes, IMHO the two sides are better in one patch, hence
the two helpers need better to appear in one patch to show the pairing of
them.  That's what this patche does.

Then, from any helper POV it's better one helper introduced together in the
patch where it will be used to justify the helper with the applicable context.

From that POV, the clean way, IMHO, should be that we have one prior patch
introducing the reader/writter helpers, together using it globally with
existing users.  Then the kvm patch can use the new helpers.

No strong opinion here, though..

Thanks,

-- 
Peter Xu



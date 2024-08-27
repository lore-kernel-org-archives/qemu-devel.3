Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C066BC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 19:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj2By-0002cW-LG; Tue, 27 Aug 2024 15:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj2Bx-0002c1-Jy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sj2Bw-0005Ba-2S
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 15:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724788163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XV+GcZ/qrcH3I6y+iyaicPoLwbSGxXPAdFYFRSeT7NE=;
 b=TtSaHes0bXSh8gO6IN0mdMyhx7ne8cxXS5KhlwJ9VcD2D82GafpqaWlDEQIwhu8PpVTpyp
 q4vTXCP9GEq8+KEa+oKSekNGXc31OLpjtsj22iAAMirYXlbe/AGvpkKDRd792QizvrHVSF
 2pwdswE0by0Bvw//hcQ6TxrnyI4zjr0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-CD-wQ27bPxG4CDWqbyXvxw-1; Tue, 27 Aug 2024 15:49:21 -0400
X-MC-Unique: CD-wQ27bPxG4CDWqbyXvxw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d0b29198so699846085a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 12:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724788160; x=1725392960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV+GcZ/qrcH3I6y+iyaicPoLwbSGxXPAdFYFRSeT7NE=;
 b=PVcwnOr8yokt9zZp49H4TljfHnDThnuD/opk9Fv/VAY4Yu3Pm9VgVd6Z7CpoRLm9OL
 kZedcJsgm9MWF/+r0Fm8Qpi3FFZ02eWQOGJdoX0ExSzWDb1h6jIoCA6tBmAljxQ4fYzO
 0PaO4Pxp/sIzyOl4UwWc9Svabz5OKjYZZhjZaU6xfxO98bTcIGS0EhNMvloTjVhTb+vA
 eBv1PmHH6+W6MizXyWK6bI4JC49/WYJ72oPPArcD9Zc6sHNnjQqidCLoaM6kj1Vw6xhy
 3rR0DAJwtUhIlqxyXCK1vlmw3oBloTGYkN4ip17B06oboEFC1aryj/Vr5EOx03Qdpuqs
 VIEA==
X-Gm-Message-State: AOJu0YzVpKb78Z6a/jhBuA86N1J/hNuJKtyG0ubVQn5KIPLLeIRmSTt5
 ax1WXKQvUFuU6opTe913KmOb4mvZU9GNnJ6+XOyMf8az2zObe9HRW/TQbqdecAGaOFe47tymm0K
 ovv+O3e3QbcsGFmKG4mtPPopCTwXCtOgWdy50LjJSpQFqJ/Uakh2G
X-Received: by 2002:a05:620a:28c8:b0:7a1:62ad:9d89 with SMTP id
 af79cd13be357-7a7e4e6d3c1mr441335785a.64.1724788160391; 
 Tue, 27 Aug 2024 12:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECGTTNRd7H0QJp76Ut4PBQnqdWnu6Bzcf2XJuK5TEkgz88WC3+kglIREPSQMji+uWKxa/PvA==
X-Received: by 2002:a05:620a:28c8:b0:7a1:62ad:9d89 with SMTP id
 af79cd13be357-7a7e4e6d3c1mr441334385a.64.1724788160086; 
 Tue, 27 Aug 2024 12:49:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3cf6cbsm577384185a.83.2024.08.27.12.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:49:19 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:49:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 18/19] migration/multifd: Stop changing the packet on
 recv side
Message-ID: <Zs4tvVbGvHgESZca@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-19-farosas@suse.de> <Zs4V8HajCAzNS3ZZ@x1n>
 <87plptx0so.fsf@suse.de> <Zs4jeFpSgp1osMn3@x1n>
 <87h6b5wytt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6b5wytt.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Aug 27, 2024 at 04:27:42PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Aug 27, 2024 at 03:45:11PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Tue, Aug 27, 2024 at 02:46:05PM -0300, Fabiano Rosas wrote:
> >> >> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
> >> >>          return 0;
> >> >>      }
> >> >>  
> >> >> -    /* make sure that ramblock is 0 terminated */
> >> >> -    packet->ramblock[255] = 0;
> >> >> -    p->block = qemu_ram_block_by_name(packet->ramblock);
> >> >> +    ramblock_name = g_strndup(packet->ramblock, 255);
> >> >
> >> > I understand we want to move to a const*, however this introduces a 256B
> >> > allocation per multifd packet, which we definitely want to avoid.. I wonder
> >> > whether that's worthwhile just to make it const. :-(
> >> >
> >> > I don't worry too much on the const* and vars pointed being abused /
> >> > updated when without it - the packet struct is pretty much limited only to
> >> > be referenced in this unfill function, and then we will do the load based
> >> > on MultiFDRecvParams* later anyway.  So personally I'd rather lose the
> >> > const* v.s. one allocation.
> >> >
> >> > Or we could also sanity check byte 255 to be '\0' (which, AFAIU, should
> >> > always be the case..), then we can get both benefits.
> >> 
> >> We can't because it breaks compat. Previous QEMUs didn't zero the
> >> packet.
> >
> > Ouch!
> >
> > Then.. shall we still try to avoid the allocation?
> 
> Can I strcpy it to the stack?
> 
> char idstr[256];
> 
> strncpy(&idstr, packet->ramblock, 256);
> idstr[255] = 0;

Should be much better than an allocation, yes.  However personally I'd
still try to avoid that.

Multifd is a performance feature, after all, so we care about perf here
more than elsewhere.  Meanwhile this is exactly the hot path on recv
side.. so it might still be wise we leave all non-trivial cosmetic changes
for later when it's against it.

-- 
Peter Xu



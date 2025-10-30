Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A545CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWJi-0001Dt-7P; Thu, 30 Oct 2025 13:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEWJc-0001DD-7d
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEWJT-0008O5-BK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761844773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=juqH4bSfnLECsaET/vZDKGKqwUn+Zl7zxV7xLUO8hoI=;
 b=fy9gI7iD9et1T0bl7ZMyhQNGLa+qEbnI7UtF+VzOfHJXvK4lC4+Wcob/RKjUlJPxVPb1zX
 py0gq/hKPOC5yc1vPyNCSRlFs8P5tmif7JFB7Ls/LMm7I9A20xtUX2s+AV0LgqWe4n7LtK
 F/RvPZAZoprzG/ixiR7b++V7KkgVzus=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-t2XOVk4LNjmXkNbLrKOh-A-1; Thu, 30 Oct 2025 13:19:32 -0400
X-MC-Unique: t2XOVk4LNjmXkNbLrKOh-A-1
X-Mimecast-MFC-AGG-ID: t2XOVk4LNjmXkNbLrKOh-A_1761844771
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-89eb8ee2a79so629565185a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761844771; x=1762449571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juqH4bSfnLECsaET/vZDKGKqwUn+Zl7zxV7xLUO8hoI=;
 b=uPkxzqUCaj09OC4O42IpcwQgOjdwhmEr9VgvDh3mSrGO5bgQ8T+fSiidi2Z2ZYfljp
 J6a9gHgmcUOXxLfgIkp78QjPyDTbfNgG/j+vh8ssfijPrDnkEu2jDYOFhU9zbKASmPSU
 y+Ui5/ISfm/Rpt4qytYTaUDK7ANvqLLUf33WYX0hVHRcW1deWKewKGQQ3/kOMurSAljP
 o9rhxRHkg6ZptYnyKwIgF91E/q7sLKBwQOAKtYWMn5mHC7Da9JxaE5Wd7F7/JpmHX7Uh
 SpgT6IHa1mMilqof4+kVI3v9j3w+HdThSsnq1J9ugGPB70GeC8RieE2N0zZ32S5QAPPi
 YPSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqrrv3Fmf+IQ/X9bOWq3yDLDLtTp7ZH444zbDmvDAL1YawxB7QpdkMvjhYupTh/7DiMVX9gpMAW/7O@nongnu.org
X-Gm-Message-State: AOJu0Yyaay/5YBaSOzkt8+V4RGYYEbnX1a++bLnp5UBfOvG7kib38Ry1
 R95zsW0X/crsSTxTMIXzaXM3grTm2dMb3EfIEa3XTQTfUQ8rLIMfd0nriUyR5oCJHF4J745vMg7
 Q5lz1IbriV83DHZx81Z+OXOfjrT2j741EuQwsx4sjLn6d9xMITOKGfuQb
X-Gm-Gg: ASbGncsnv2tgXFMBzTYLAoi8cZqmYumCBIvovGqIb95QDt2oXejlDafAjGNrDhK0nwu
 meMMCWssBjwkCUw8E+uyJijxeaGkrMvfUT/Mf8Yw4vFUh1jurrM4Gvx+uTSlSJK+OIgkjyNt61n
 /fs9F9tTtosbuWSHODijUU/IgLJXxi+lWinnZMPIghj0V777FtTQfxKquxc6E0rSLyndeL3+tpV
 twFNQkxvJEObP2Ncwh+v81bAX8oRbkdfAm5qoJgYnYLPhKyyBzEeWf0Ca8BOTGL9PahBinRCJe8
 T1hNeXyR+rALLeMplpPWd06Vc5ysX+gFfg5cfmvmULB4rTJjH643ofJozcsGXWUAZ9g=
X-Received: by 2002:a05:620a:2951:b0:8a2:fab3:bf8b with SMTP id
 af79cd13be357-8ab9acedcb2mr29574785a.48.1761844771381; 
 Thu, 30 Oct 2025 10:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF27pBmSkr3omiABsuhwgTruxHt8rTn58NLvshSiP5baWjtqDQpF6GU3KxwZ9rVr+xOQsUH4g==
X-Received: by 2002:a05:620a:2951:b0:8a2:fab3:bf8b with SMTP id
 af79cd13be357-8ab9acedcb2mr29561385a.48.1761844769408; 
 Thu, 30 Oct 2025 10:19:29 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f254a41cdsm1290629685a.29.2025.10.30.10.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:19:28 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:19:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC 00/22] migration: convert vmstate_load/save_state
Message-ID: <aQOeHqILFfBdlhJb@x1.local>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
 <aQOc7ogTLqs8iML0@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQOc7ogTLqs8iML0@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 01:14:22PM -0400, Peter Xu wrote:
> On Wed, Oct 29, 2025 at 02:13:24AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> > 
> > That's a proof-of-concept for converting vmstate_load/save_state
> > to have boolean error value, to fixup this analysis
> >   https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
> > in code.
> > 
> > As many of .get / .set handlers call vmstate_load/save_state,
> > let's convert them too, it not too much.
> > 
> > And finally, while touching each file, let's also use
> > new pre/post _errp() APIs.
> > 
> > So, this series propagate a lot of errors through errp, which
> > were simply printed out before.
> > 
> > Why it is an RFC:
> > 1. I didn't yet double check the accuracy of all patches
> > 2. Maybe, commit messages need to be more detailed, maybe they
> > need more arguments about correctness of the change
> > 3. Maybe, it's better first merge new generic interfaces, and
> > than send per-maintainer small series, to avoid this huge
> > series, depending on many maintainers.
> > 
> > So, I don't include in CC many maintainers now, to get a first
> > look from Markus and Peter.
> 
> It's still good to collect more opinions on especially rfc series, even if
> the list doesn't need to include maintainers for each device. I added
> Fabiano and Dan too.
> 
> > 
> > What do you think?
> 
> In general.. I liked it. :) Thanks for trying it.

Oh wait, so this is still not the full list of what needs to be done?
After I applied your patchset, I still see:

$ git grep -E "\.get | \.set " | wc -l
214

Some of them are outliers but most of them look not.. :(

-- 
Peter Xu



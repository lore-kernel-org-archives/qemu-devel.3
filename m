Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7C9CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 14:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs1ot-0002fA-5r; Wed, 03 Apr 2024 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs1oq-0002ey-F8
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs1ol-0006oj-IR
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712155342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lr2huBix4QmSlqCbVDfM4hIC7ZEHHKMrGGublh1TTwU=;
 b=B4MSHa/G7GfJVM+7j6hYhJPSKnf5lqJ3V8ulhU86AOpr8oNxPsfwQkddCLsMdwsNVPeI24
 I8FFIZIZUhobZGWW9uCzvkbNMCDkw9JMjj6XOqCWZ0XUcD4An0adfVaUJW863dIfJe3KSS
 fVGGHBrorIx/EPJLe4E5tq9Xt44Qut0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-aJ5DBI4sPR2f5WMsbKapWg-1; Wed, 03 Apr 2024 10:42:20 -0400
X-MC-Unique: aJ5DBI4sPR2f5WMsbKapWg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6992d40ea4aso518006d6.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 07:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712155340; x=1712760140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lr2huBix4QmSlqCbVDfM4hIC7ZEHHKMrGGublh1TTwU=;
 b=BpM7KftztECitdvfIYoWB3xVBza53YapUyuNdFKIeuBkisqJ+fv76hF6OoEINpY9I9
 VKLYNPcH0GUDtzkCA0aJZmB5k79T+BvSFyCFbyuk7mYQVOSzjYRQ8C+JYQiRVAEVGaNj
 nZS1Ccv85SpOWO/wvYuLZAlf1hXUBd/91rQvfokXV4OZY7U46BDXgYmyb/fZeR/GyYha
 v6Xi8uvhA2DQvjHCQ4kiOEJcKGOf09Mp8QAYE+XnfdfSwWJvJWVq9AKAulIj1lOSs6ip
 EAKj+vMCtS7ntEk88qFwWx8+JPJThIiQMTpIryujv+3OKrMauR+PptAZVOotC0DMtbve
 DZYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYbiQ0fpQbaNYJvfRlmWwOBpc5SmN+WM/oUDeMgk2kILcDRr01GD5fgJ3hCKe6wu1rhp+kOooBaerIMNO2qv5kQciqNdk=
X-Gm-Message-State: AOJu0YzBY2qEv8/u/fxkSSf1qrixDRIuN8LHFF0O7AYi/GpmdIZuwUii
 R2c4Hvfq5wdbtqB3Q0ldRXTacQxf+/R9VZSevE2VpKB9oc4OQQCljec2koaUQgRJsChVbyN3fxC
 U5psi1uhY8dC7T4nluAXnJH0+TRqxX6AYfX7Kk3Rg/YT77A2/5YGI
X-Received: by 2002:a0c:c792:0:b0:699:dfe:6015 with SMTP id
 k18-20020a0cc792000000b006990dfe6015mr7281695qvj.5.1712155339762; 
 Wed, 03 Apr 2024 07:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNf4d+SLf4psHDSOnie9MoCbAsM2FPjb3OkYDB6mW6GLwKHdGMlatSedXouYnMLzgaGSGEHg==
X-Received: by 2002:a0c:c792:0:b0:699:dfe:6015 with SMTP id
 k18-20020a0cc792000000b006990dfe6015mr7281663qvj.5.1712155339035; 
 Wed, 03 Apr 2024 07:42:19 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k2-20020ad45be2000000b006990a16eddfsm2977284qvc.28.2024.04.03.07.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 07:42:18 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:42:16 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Message-ID: <Zg1qyEJZH8kScSng@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
 <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com>
 <Zgx7DI4LXYrR_dk-@x1n>
 <c0607330-60af-4e0f-819e-4a22a38edd6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0607330-60af-4e0f-819e-4a22a38edd6d@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Apr 03, 2024 at 04:35:35PM +0800, Wang, Lei wrote:
> We should change the following line from
> 
> 	while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {
> 
> to
> 
> 	while (qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {

Stupid me.. :(  Thanks for figuring this out.

> 
> After that fix, test passed and no segfault.
> 
> Given that the test shows a yield to the main loop won't introduce much overhead
> (<1ms), how about first yield unconditionally, then we enter the while loop to
> wait for several ms and yield periodically?

Shouldn't the expectation be that this should return immediately without a
wait?  We're already processing LISTEN command, and on the source as you
said it was much after the connect().  It won't guarantee the ordering but
IIUC the majority should still have a direct hit?

What we can do though is reducing the 100ms timeout if you see that's
perhaps a risk of having too large a downtime when by accident.  We can
even do it in a tight loop here considering downtime is important, but to
provide an intermediate ground: how about 100ms -> 1ms poll?

If you agree (and also to Wei; please review this and comment if there's
any!), would you write up the commit log, fully test it in whatever way you
could, and resend as a formal patch (please do this before Friday if
possible)?  You can keep a "Suggested-by:" for me.  I want to queue it for
rc3 if it can catch it. It seems important if Wei can always reproduce it.

Thanks,

-- 
Peter Xu



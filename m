Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186F6CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUns4-0007CM-45; Wed, 03 Jun 2026 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUns0-0007Bx-1F
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUnrx-0007Bv-1z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780501859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Of2zTFukBbedDiNTomV6vy9vrpz8rZJq6eeMxaWRkg=;
 b=RFs9eRCA50WHxfSQVMGz7II0ExOnvGv449pOt4nCRy6dtUdLGnsKxLSejEdWqyywJOEAek
 JHCLO60WioonjwJkkUo5Yt3ehL/dMvhBd7uWGknn/UtZ6/Iq2vWlh/pzIDvuwfO4/Smzcf
 ErBwgcJq52WJzPkxys4A9++Dx+vRgQw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-21AeQRiHMJCVAZM43MPniw-1; Wed, 03 Jun 2026 11:50:56 -0400
X-MC-Unique: 21AeQRiHMJCVAZM43MPniw-1
X-Mimecast-MFC-AGG-ID: 21AeQRiHMJCVAZM43MPniw_1780501855
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5176cc5bf2aso27938621cf.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780501855; x=1781106655; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2Of2zTFukBbedDiNTomV6vy9vrpz8rZJq6eeMxaWRkg=;
 b=ieOyMM3QJJi8pVxNomc61y31d/cUW4YnUPMU5xGZ8pfTNjSvbeRIbzF5zQ3bjAU8BN
 mUCQi9mmTHbSYAOZYgidrAieRfUdbFUs+rEWteCoOj+7Gqrec0/YHD4jZPK4nPxltup6
 +V5ha7ScwUAG31se7HULORs/eEvh8LpEKaF1MhqSTPYOwK1T1R3uZq9V9ho9BkdV6Qee
 ZJ1B9kPbOHAn+fHmAiKE6bgQQl2iH3QvwZ/16TCyETzdH4wjWmdL0LW088EJMnJIrIAi
 l0WLpj7GgCY4IBNfofOILRdijbhH0EEco5ZkvfKoO+xZKygIgZPxWV5VWaIKP4Q2+Mxk
 mNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780501855; x=1781106655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Of2zTFukBbedDiNTomV6vy9vrpz8rZJq6eeMxaWRkg=;
 b=hK7P4iaOVRBrkkOOl4a/zkekgCbDBZQBPMfv7wCvVolHlQIZv3a4OCPlR1RXngJaND
 ZP9lm/+coUhOwBjRJMd6dkgbd5m+/I+ipTjgdfv9nM8p+Ggmv/RtEV47xsI1URc15xH4
 74i8NvnViSCwHJsXGPoH/+qCDUAUXBXFzWzxq3CbyXV/f9whCXagiWGUJS74I6YbeLAt
 SwIG5Bc+RV4bDO8K1/CjR8MrYM/YyF38pAmlCWJC0EerfPlJ/b371cnBR8aZSYlpn8Hp
 wIPdBb3Q/x3Gl0Fy1IcQW1aGNjc8cKAEULy8Q8KweW7hRmhLY++UUFVAeyLQ2YYX9ZA0
 JlmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++dT3936CWAMK6hyIwILOdpB+B9rWKa0GGkmpEt+oakR3L5trOeXCb/iusylQmEk21Xnt8HZtRdcGs@nongnu.org
X-Gm-Message-State: AOJu0Yy7wJgWMNvGld5wVv3wjV7ues28atJ6orTFwsbR8F66CIXHo3WE
 srN55tTI368sO10ywGC6LjSjFfsnlnGGaRbH1rEFR2hCpOwR0Bjj2c0ZCRQNYwRcVY0MTRZrlFE
 ikRfqPNNmfksTg60j43FQQGE0eM3ZS6IlpJevRiNIkvD/Zhnp0fNmZQ+2
X-Gm-Gg: Acq92OGgQ7MfCQirvEYbLFebMkjgytDMU2pZTEIjQ9Y985FvxvfD8YvUEVVWipUR4Yz
 awIU0zFodbfA3emMcsfGdDOFQTHFjpTXLbRnkBl/8WTufTl08X+yS3lGK+IjQ1Z3el69yhiU47T
 Ecio7VmKs45+CpyYlUeoZDhxnqTbnR167gVcA/2aa3nyhGzAbax7EVXCeSGKpN6V0bBYzupgVgO
 NhNJYd9M6Dm1frqZbmEJVADceELr99Lcz5ndgdAHVgmKz0nMy7omUF05Gf7iGww6MUnF2s6li+9
 zNfXT6pi1Kvp7TrqSDlUjJRgezR6YArXnHRxLovds7cYrErI/9RIP6epOBEU3L3kR68VKJQ0Wwk
 S/hrTJn/UZp7WHmqUZb+7r4VRSA==
X-Received: by 2002:a05:622a:652:b0:50d:a987:89b2 with SMTP id
 d75a77b69052e-517786d588amr56761571cf.31.1780501855459; 
 Wed, 03 Jun 2026 08:50:55 -0700 (PDT)
X-Received: by 2002:a05:622a:652:b0:50d:a987:89b2 with SMTP id
 d75a77b69052e-517786d588amr56761021cf.31.1780501854906; 
 Wed, 03 Jun 2026 08:50:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775dbd2c9sm27190241cf.23.2026.06.03.08.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:50:54 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:50:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiBNXUU0xcT_UbKO@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah_4hixGcNv-CLfv@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 03, 2026 at 10:48:54AM +0100, Daniel P. Berrangé wrote:
> On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
> > On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
> > > >
> > > > This series introduces a generic way to specify migration parameters that
> > > > can be used even during the early boot phase of QEMU.
> > > >
> > > > One example use case that already existed is CPR-transfer / CPR-exec.
> > > > currently QEMU has a temporary global variable (incoming_mode) to achieve
> > > > this, but it's hard to understand and this hack bleeded into quite a few
> > > > places that we could have avoided.  The lines in patch 2 touched may
> > > > provide some idea.
> > > >
> > > > With a generic approach of setting migration parameters with cmdlines, we
> > > > can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> > > > as before.  To CPR maintainers and reviewers: please have a closer look,
> > > > even better if it can be smoke tested, to see if this works for Oracle's
> > > > environment, TIA.
> > > >
> > > > The 1st patch implemented that new semantics.  It is straightforward: now
> > > > we can setup any migration parameter using an extra line of:
> > > >
> > > >   -incoming config:key1=value1,key2=value2,...
> > > 
> > > Just merge my code mate.
> > > https://lore.kernel.org/r/20251215220041.12657-25-farosas@suse.de
> > 
> > Heh, I apologize. I totally forgot it even if I seem to have read it..
> > 
> > The goal is differnent, though, which is to make it available before
> > migration object initialization.  Say, I wished -global would work too but
> > it doesn't, and it just can't.  So it's not "something good to have"
> > anymore, but functionally required for either CPR and TAP in the future if
> > we adopt this, they'll all read them early.
> > 
> > > 
> > > A couple of differences from my patch:
> > > 
> > > - old-style keyval vs. json;
> > > 
> > > Isn't json preferred nowadays?
> > 
> > I didn't mention it in doc, but yeah this series also supports JSON due to
> > the same qapi helper used.  I don't suggest json though for this entry (and
> > that's also why I didn't mention it..) because 99% of migration parameters
> > are scalars and I don't see why we should use JSON here.. the only one not
> > scalar is block-bitmap-mapping but it's not intended to be used in
> > -incoming at all (even if it'll work..).
> 
> 99% of **todays** parameters are scalars.
> 
> The reason we are actively moving to CLI args which are modelled with QAPI
> and expressable using JSON is because that future proofs the command line
> for any kind of parameters we might need.
> 
> We should actively document and promote the use of JSON.

Ah OK, sure, will do when respin.

> 
> > > - using "config:"
> > > 
> > > This makes it non-uniform with uri and channels which don't have a
> > > keyword in front of them. I guess I could live with it, but it seems
> > > odd. I see that it makes parsing way easier.
> > 
> > Yeah, having some identifier would be nice.  I wished channels also have
> > identifiers if we don't need to keep compatibility.
> 
> IMHO having a magic "config:" prefix is an anti-pattern because it
> involves custom command line parsing logic.

Yes, it's not elegant.  I wished we had something like this though when
introducing the cpr channels; right now anything wasn't "defer" or URI
implies it's a "channel"..

I also wanted to avoid introducing new cmdline parameters, so migration
incoming cmdlines can stick with the same option.  If there's better
suggestion please shoot.

> 
> Does "-incoming config" imply '-incoming defer' semantics or is it
> independent ?  

They're independent.  Examples:

 a) "-incoming config:* -incoming tcp:*", setup parameters for TCP incoming
    migration without further deferral

 b) "-incoming config:*" only, setup global parameters for a possible
    upcoming outgoing migration

Thanks,

-- 
Peter Xu



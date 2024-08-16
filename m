Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9459C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezTw-0006Qc-Qu; Fri, 16 Aug 2024 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezTu-0006PY-PB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezTs-0006aN-Pi
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723824431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOoHG3i4BpiPV7VZMDR4olz6SKvarhtsXPpSakoNZ3U=;
 b=YwtZY/wX873TwBcUHH90BnZ/NXLgsksw9oOmmsw3wjBCu2GWRnf8hM7Ig2qtP711kA3sLK
 twg8XDeVaQLnzQWVkFprVszfprOBRp5nwEfhFLbvGxda3OoEh7+8I5TyQvT1UMk8KpZbqx
 5as2/zdKuLVWoc33BtH7zY7kWmcQqQ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-xqWvy2jnMzykxSpZVA1Ziw-1; Fri, 16 Aug 2024 12:07:10 -0400
X-MC-Unique: xqWvy2jnMzykxSpZVA1Ziw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a1d6c57f9fso1724185a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824430; x=1724429230;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOoHG3i4BpiPV7VZMDR4olz6SKvarhtsXPpSakoNZ3U=;
 b=qpyNaYdw8Gv4vQczcUdBRXNfzGmN9wX5DWt0t2J4As4kD5p9hIL03dEBf8j1mH3tu5
 IPPVTL/NmIkkUo57o5Xk0BreSns0SIBjzIejCdFr6+3lMIeAdjNNusytKsKTDemKb9mX
 g8qi6ikzzaFmdlj07rm/4KVtNQTT3jZZGQ+c0ADTJ7Z9M4VGg5rOQonI93689uVmWC2u
 eVy5gNXtkXv28IIdvM3wpAPL0T6jPdPIuRWmV0Nn8QBqyJvomObb9ht14U5L56EWPlft
 9034kNacU/rjTY1835SmgAbu0S4T9Bglzwurg/gpeVErbsKm2phXKdZgx+/e4n7VQxq4
 DIlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDpueDqPmawFudoN6ucK8nxLkA1OAXEVcU17i9tYqg9QgS2ogUg39B47QIb2tGVvwM1ZagBWRn3Nk@nongnu.org
X-Gm-Message-State: AOJu0YzGQCw+aHCYwoGC5qQ10QCKH/s4uplO2rxI7PsnAY3ZbJ+83qJH
 //8iu+1RtfEmLg24ePsxg/1QbOF5JOZQKJYI46tKAqJlNudmSkmhi/ePDeE4xiqtHWvNGFICp5Z
 jtIItFOz4YmUygTM7vs3KAV6NyjUc3Dhb2W5x6WCeQoBYTxp2GGUu
X-Received: by 2002:a05:620a:4507:b0:79f:70f:ee0b with SMTP id
 af79cd13be357-7a5069c3311mr226867785a.6.1723824429818; 
 Fri, 16 Aug 2024 09:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDfRkNU/CiTJlxrCo7SNUsgf+T+CSpMRf7uJpFW2XAZ8ohPM9w08dcfxjNnNucnyMlfVi50g==
X-Received: by 2002:a05:620a:4507:b0:79f:70f:ee0b with SMTP id
 af79cd13be357-7a5069c3311mr226863585a.6.1723824429126; 
 Fri, 16 Aug 2024 09:07:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0fb469sm188151885a.107.2024.08.16.09.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:07:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:07:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr95K3-Df8fHZ66w@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n> <Zr8Q3rgoKkh1ohTG@redhat.com>
 <79cf9d92-9abe-4045-8789-4e3b13102751@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79cf9d92-9abe-4045-8789-4e3b13102751@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 11:14:38AM -0400, Steven Sistare wrote:
> On 8/16/2024 4:42 AM, Daniel P. Berrangé wrote:
> > On Thu, Aug 15, 2024 at 04:28:59PM -0400, Peter Xu wrote:
> > > On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > > > > The new user-visible interfaces are:
> > > > > >     * cpr-transfer (MigMode migration parameter)
> > > > > >     * cpr-uri (migration parameter)
> > > > > 
> > > > > I wonder whether this parameter can be avoided already, maybe we can let
> > > > > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > > > > in the same channel?
> > > > 
> > > > You saw the answer in another thread, but I repeat it here for others benefit:
> > > > 
> > > >    "CPR state cannot be sent over the normal migration channel, because devices
> > > >     and backends are created prior to reading the channel, so this mode sends
> > > >     CPR state over a second migration channel that is not visible to the user.
> > > >     New QEMU reads the second channel prior to creating devices or backends."
> > > 
> > > Today when looking again, I wonder about the other way round: can we make
> > > the new parameter called "-incoming-cpr", working exactly the same as
> > > "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> > > be reused for migration incoming ports?
> > > 
> > > After all, cpr needs to happen already with unix sockets.  Having separate
> > > cmdline options grants user to make the other one to be non-unix, but that
> > > doesn't seem to buy us anything.. then it seems easier to always reuse it,
> > > and restrict cpr-transfer to only work with unix sockets for incoming too?
> > 
> > IMHO we should not be adding any new command line parameter at all,
> > and in fact we should actually deprecate the existing "-incoming",
> > except when used with "defer".
> > 
> > An application managing migration should be doing all the configuration
> > via QMP
> 
> This is devilish hard to implement for cpr-uri, because it must be known
> before any backends or devices are created.  The existing preconfig phase
> occurs too late.
> 
> One must define a new precreate phase which occurs before any backends or
> devices are created.  Requires a new -precreate option and a precreate-exit
> qmp command.
> 
> Untangle catch-22 dependencies amongst properties, machine, and accelerator,
> so that migration_object_init() can be called early, so that migration
> commands are supported in the monitor.
> 
> Extract monitor specific options and start a monitor (and first create
> monitor chardevs, an exception to the "no creation" rule).
> 
> If/when someone tackles the "all configuration via QMP" project, I would
> be happy to advise, but right now a cpr-uri command-line parameter is
> a sane and simple option.

So far it looks ok to me from migration POV, but that definitely sounds
like relevant to whoever cares about this go-via-QMP-only project.   Let me
at least copy Paolo as I know he's in that, maybe anyone else too just to
collect feedbacks, or just to let people know one more exception might be
needed (if no NACK will come later).

Thanks,

-- 
Peter Xu



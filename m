Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D506CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 21:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts7Hq-0000EX-6b; Tue, 11 Mar 2025 17:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts7Hn-0000DX-Vs
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 17:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ts7Hm-0007Ml-AH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 17:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741729032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEmpEWCk+e4EPCA8b5jZ5KE8WPnE3YojRubR+DYfYxQ=;
 b=MC+q/c3/kVAwu6EB+vD1nvcONWYABMZEATNOd2V2ZBuHM1A+IccWTMMXeAutUZCmNaIGpm
 C0KYe4xR94D/iywIlqs+npi8+xvNN/LQfdr551lt19XuRnqHA4SByU4ckhiG4ilIDTsxyL
 sm8UJqwM8HYB5jvBKSOniPJsLgZKavk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-ERXtyoyeNT2ebBI09Y_Jzg-1; Tue, 11 Mar 2025 17:37:09 -0400
X-MC-Unique: ERXtyoyeNT2ebBI09Y_Jzg-1
X-Mimecast-MFC-AGG-ID: ERXtyoyeNT2ebBI09Y_Jzg_1741729029
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c0b3cd4cbcso667823285a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 14:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741729029; x=1742333829;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DEmpEWCk+e4EPCA8b5jZ5KE8WPnE3YojRubR+DYfYxQ=;
 b=nIxz98756kfmIE+IwabufmSUSYsu6nRm8ezhbeMJjSDuncnVfDnBqlvmHJoljr6d2J
 lVgWrBiO2Gc7T31+NoOJbLHpQkH75zbDT29fiWAOVVF4vUcyJY2f4Iiudjt9UjGWAGna
 jLO4nuAnP7j9ZEEmkizfnJ8NjrbKoJljbRUzSGkm383V1xG08xPz2SjSunrcrklLQTyg
 4b6BnSo/jGjXrQjf3TN36I0aX5+4yMoFCzT8p346pFTqcu2cfpNlwdcy/Aua3qbbxJK6
 hV0vqa275sQwoMMbxUouyIF6VwfVNPNLIGi/xzLMqOauAeu0op86wGhbBsD3ZM4CfVml
 7zIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeLlIhOAAV8FucPmFT+mipbOBjHfFN7YgZxlDj4hEEemljPW0YTjhVQ28yizpNha+kSiLgc4860bmZ@nongnu.org
X-Gm-Message-State: AOJu0YyonSfL0ICwwQgO97UamoLB9yH2nTGIzPmmHJnEMPCGlO13nLT8
 OKd18JaOmijEoxTP3JMFFMxfl21fcwz7jX2vCzV/bjEJs0Ls7J0P0KDx2Wzx4nilcq9tfDS0Mwc
 y3gALPJFo4BBsEUBB74nP42sWf/F77Y19FjT457Damx2QMFMRZH8+
X-Gm-Gg: ASbGnct8pHXvsNqYpOmduCPM9uQH5O5g58Ce7aOm3yMLf948jcPuvmSKXmA/IO/ILcr
 7OIcHEw0WLsxEEpH5mJusVVrll3wYV2NelfZNwzjI6C6UFn42BjIasLW++kIyUzdP07leq9T9FF
 TBXGDPW5MNdAN1Fdk700AqQ8LW/XG13uBYPQldByE6+TuOo+MQf/r8X50ewyNe8ZGX3foRiqQmI
 pGrFm/uwzZ3cgb02rN19P+vTMU2Bmb8D4L0tDROA2cFmNqo2FmYm6dT4lCLWteoHKC1NdH1hf5R
 8xtMuuw=
X-Received: by 2002:a05:6214:230f:b0:6e8:fad6:7104 with SMTP id
 6a1803df08f44-6e9006ea033mr232117706d6.35.1741729029000; 
 Tue, 11 Mar 2025 14:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYLGVNQxvvJhFYTKvx+aT4RPXYdUN6dSuWwEuFwFqnVqMVPvY/zim7QE0PKrXlebJ3ucAiOg==
X-Received: by 2002:a05:6214:230f:b0:6e8:fad6:7104 with SMTP id
 6a1803df08f44-6e9006ea033mr232117346d6.35.1741729028573; 
 Tue, 11 Mar 2025 14:37:08 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f70a4485sm76529406d6.53.2025.03.11.14.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 14:37:07 -0700 (PDT)
Date: Tue, 11 Mar 2025 17:37:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Manish Mishra <manish.mishra@nutanix.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, farosas@suse.de, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue
 on ENOBUF failure for sendmsg
Message-ID: <Z9CtAAA1HH-c7CHd@x1.local>
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local> <Z8_wnLIlfhM7bILZ@redhat.com>
 <Z9BU0gd3BLPhBss2@x1.local> <Z9BXw6iZfi_UKx-t@redhat.com>
 <Z9CVr9jbcq810U2i@x1.local> <Z9CYIqgyD4E6U38x@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9CYIqgyD4E6U38x@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 11, 2025 at 08:08:02PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 11, 2025 at 03:57:35PM -0400, Peter Xu wrote:
> > On Tue, Mar 11, 2025 at 03:33:23PM +0000, Daniel P. Berrangé wrote:
> > > On Tue, Mar 11, 2025 at 11:20:50AM -0400, Peter Xu wrote:
> > > > On Tue, Mar 11, 2025 at 08:13:16AM +0000, Daniel P. Berrangé wrote:
> > > > > On Mon, Mar 10, 2025 at 04:03:26PM -0400, Peter Xu wrote:
> > > > > > On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
> > > > > > > Given this is in public API, the data needs to remain reported accurately
> > > > > > > for the whole deprecation period. IOW, the patch to qiochannel needs to
> > > > > > > preserve this data too.
> > > > > > 
> > > > > > :-(
> > > > > > 
> > > > > > We could potentially mark MigrationStats to be experimental as a whole and
> > > > > > declare that in deprecate.rst too, then after two releases, we can randomly
> > > > > > add / remove fields as wish without always need to go through the
> > > > > > deprecation process, am I right?
> > > > > 
> > > > > IMHO that would be an abuse of the process and harmful to applications
> > > > > and users consuming stats.
> > > > 
> > > > Ah I just noticed that's the exact same one we included in
> > > > query-migrate.. Then yes, the stable ABI is important here.
> > > > 
> > > > So for this specific case, maybe we shouldn't have exposed it in QMP from
> > > > the start.
> > > > 
> > > > To me, it's a question on whether we could have something experimental and
> > > > be exposed to QMP, where we don't need to guarantee a strict stable ABI, or
> > > > a very loose ABI (e.g. we can guarantee the command exists, and with
> > > > key-value string-integer pairs, nothing else).
> > > 
> > > QMP has the ability to tag commands/fields, etc as experimental.
> > > 
> > > libvirt will explicitly avoid consuming or exposing anything with
> > > an experimental tag on it.
> > > 
> > > > Maybe what we need is a new MigrationInfoOptional, to be embeded into
> > > > MigrationInfo (or not), marked experimental.  Then in the future whenever
> > > > we want to add some new statistics, we could decide whether it should be
> > > > part of stable ABI or not.
> > > 
> > > That is not required - individual struct fields can be marked
> > > experimental.
> > 
> > Yes that'll work too.  The important bit here is I think we should start to
> > seriously evaluate which to expose to QAPI as stable API when we add stats
> > into it.  We used to not pay too much attention.
> > 
> > With MigrationInfoOptional, we should suggest any new field to be added
> > there by default, then whatever needs to be put out of experimental needs
> > explicit justifications.  Or we can also document any new migration field
> > at least in the stats to be marked as experimental unless justified.
> > 
> > > 
> > > The key question is what the intended usage of the fields/stats/etc
> > > is to be. If you want it used by libvirt and mgmt apps it would need
> > > to be formally supported. If it is just for adhoc QEMU developer
> > > debugging and doesn't need libvirt / app support, then experimental
> > > is fine.
> > 
> > To my initial thoughts, I want Libvirt to fetch it.  However I don't want
> > Libvirt to parse it.
> > 
> > For example, for things like "whether zerocopy send succeeded or not", or
> > "how much time we spent on sending non-iterable device states", they're
> > almost not consumable for users, but great for debuggings.  It would be
> > great if Libvirt could know their existance, fetch it (e.g. once after
> > migration completes) then dump it to the logfile to help debugging and
> > triaging QEMU issues.  In that case parsing is not needed, the whole result
> > can be attached to the log as a JSON blob.  That releases the burden from
> > the need to maintain compatibility that we don't really need and nobody
> > cared (I bet it's the case here for zerocopy stats, but we got restricted
> > by our promises even if it may ultimately benefit nobody..).
> 
> We already log every single QMP command & response and event we deal
> with, at INFO level, but by default our log files are only set to
> capture WARN level, so this isn't visible without extra config steps
> by the ademin
> 
> Possibly we could think about dumping all migration stats to
> /var/log/libvirt/qemu/$GUEST.log at migration completion

Yes it would be great to have it if it's trivial to get.  It could be a
last round of 'query-migrate' dumped only on src after migration is
completed, right before src QEMU shuts down.

Thanks,

-- 
Peter Xu



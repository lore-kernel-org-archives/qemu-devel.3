Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68610CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEAA-0008Dv-4S; Wed, 27 May 2026 09:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSEA8-0008DI-3O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSEA5-0006Eu-60
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779887944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9oX42Xk2rXgUDKnfiOJxs2rn/DuWxQJUwh46/kWh5U=;
 b=VseH/4X10AoIKNEgTRxtcZryNbN2YKD3N8crDz5MtiRVf0IbEQgKVz8PBqg/wvxnIVd8Et
 Q85ZOKdrJjzB9LhiOG4CTVvnIlDLkZjJRDBj4PuYyON7/ctnumy/c5UR9KgJOuByfQ2YIo
 lIzC+OY031Dil+JnTJMzYFWY9cwaQD4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-7JLmhcLnP9yuAZs1W313hA-1; Wed, 27 May 2026 09:19:02 -0400
X-MC-Unique: 7JLmhcLnP9yuAZs1W313hA-1
X-Mimecast-MFC-AGG-ID: 7JLmhcLnP9yuAZs1W313hA_1779887942
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914c8954923so725175485a.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779887942; x=1780492742; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y9oX42Xk2rXgUDKnfiOJxs2rn/DuWxQJUwh46/kWh5U=;
 b=OebD0sfDVYBqPDwx0AF//b2XfxhLKOmTgWAzuOx7xiImCkAr5y62miQ02E/ZXvHymg
 ywvCmGEg7D89AGKC0FVH/3sgGqtOozLadQbwKFExk6v9X7bv9UmjdNEBJTrh4n5AdNI2
 bqSD8JeMGWsehOQ1w58bC6cXZ5uxMiJI/WmI053ETja7vgsgeFquh7qK1iYh066zJGXQ
 wExmx6N1B1m1Lq3eyWk2feztHVThtunbsjg2gKxtVXIAxx4KP8gGLc6aSGtpl/Wj6kaw
 vukbfuZkIpKnDYgCWNq23dqwOh5EUr+oraYaBooI5CZAon6LgXvmzI40gKpYL54g3ydn
 R9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887942; x=1780492742;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y9oX42Xk2rXgUDKnfiOJxs2rn/DuWxQJUwh46/kWh5U=;
 b=IPTkaDUnBFr7Y67+4OcW3cwPbXqoAwDCXxIYKtZkMrdpP9t8qOdtiEhS9rPV8u2BU+
 fEKAds7QUdO/3UwLsFHgaG1OB6Vumin2PnayRuXL3Jxqr8/GQWK+hoiFbveq2YMgu3jW
 aoYPe1XNQ50rh00oCwZRHmnM/fNWl8yfmU5Xazh0sbn6KawILmzTMsBh5+1iqK0XBpsd
 pjlP8Rzoec6zQt1LetRRqcZrVXgcG6SsxUOrZji9ii/Pe7ZT5vHqzY6LVRzRrY//ih5u
 mBBGBSgrKqlgY2kBLDxWhQ4G955eLxU/7MuraSGrsvUxgmbAanE5wOTf/dF2ODBBXkDB
 zB7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2cGKdfcdvE0frnxGGcAsR4NbA5mnzRO1Kiu427/vVFSFvjzl8PM73CXZlGYAQZszgRMTbR2argPFE@nongnu.org
X-Gm-Message-State: AOJu0YwD70eUtWF5o6NgxZWiiYlYluR15WU5B5pHg8HhjCRFVrH6XrKP
 ZHCrXgceau47JHaPuIOqqLYw6JIL/4L6YJLwyhLqbqrsQ5ne56wV55afvj9jgyrW4S6EUS2UM29
 uJ/6jEvYblGERoTwhM1RT8kAwedolBHqWfhiKTdlN/u/IVQtFydSbblTP
X-Gm-Gg: Acq92OEIE15VpdY48KBNtrbm5HADu2L7PQ3V5tJlhFUc09l1YRtXAELrjzuapVVOCcy
 qXOLtQgYGNaRVYYy+fdrLhW/Fc0Hf0VBjN4tO6clx086yKhIcrmY2PeOo59Y/KZD8LJa9EKgRWR
 hnMsR5V+waC2xW5i4qAWyGnJGt+pL9kpp35YtglI3P6+UtjT1Hb3wuaO50mdCeykS72AqLUfZMz
 z2+OxXQUgzcnt3KB3rh8HXJEbe3di4Vsm9UEZfAFlJrZW9+oU/Llczrn2G4NUeEhkzfaD4zzAd5
 BW4L3WuPYix94w/f0vELr8hUs2W91fC73oH4fEPMitgqm0xybGTYiz1dbsTRYNOwdOFLvLler4O
 BT5/3lqnSSG0euewjt4ByGmEDO0eTVN/n2ucVcGWcU9D0tIU=
X-Received: by 2002:a05:620a:448e:b0:912:bb4b:a900 with SMTP id
 af79cd13be357-914b49cdbf4mr3140487185a.40.1779887941904; 
 Wed, 27 May 2026 06:19:01 -0700 (PDT)
X-Received: by 2002:a05:620a:448e:b0:912:bb4b:a900 with SMTP id
 af79cd13be357-914b49cdbf4mr3140482185a.40.1779887941267; 
 Wed, 27 May 2026 06:19:01 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f881d91csm471616885a.44.2026.05.27.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:19:00 -0700 (PDT)
Date: Wed, 27 May 2026 09:18:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "vulab@iscas.ac.cn" <vulab@iscas.ac.cn>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
Message-ID: <ahbvQpp1mQiR8pej@x1.local>
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
 <bcc0aaa1-8d1c-4f52-a681-85bc903c8d66@tls.msk.ru>
 <6e42ecc1026a057e07e73386463bd57e1467a46f.camel@wdc.com>
 <bf46f39c-6173-4cfd-b374-63529892a1fb@tls.msk.ru>
 <87ecix59j9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecix59j9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 27, 2026 at 09:20:10AM -0300, Fabiano Rosas wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
> > On 27.05.2026 02:57, Alistair Francis wrote:
> >> On Tue, 2026-05-26 at 10:26 +0300, Michael Tokarev wrote:
> >
> >>> This change has been nominated for inclusion into previous stable
> >>> releases by Alistar.  However I've a concern here: can we add new
> >>> fields to older machine descriptions this way, and stay migratable?
> >> 
> >> I was under the impression that we could, but as I write this I start
> >> to think that no we can't.
> >> 
> >> We don't have to backport this then
> >
> > hmm.
> >
> >>> I understand riscv machine is not versioned.  How does migration work
> >>> in the first place?
> >> 
> >> As in the virt machine isn't versioned? or `vmstate_riscv_cpu` isn't
> >> versioned?
> >
> > For i386, we've pc-q35-10.0, pc-8.2, etc - versioned after qemu.
> > Each version has strictly defined set of properties, and there's
> > conversion between different versions when doing cross-version 
> > migration.  So it's possible to migrate a VM when the set of
> > properties changes.
> >
> > I don't see similar construct for riscv.  And since we do change
> > things in there, modifying set of properties in various areas in
> > the migration stream, - I dunno how migration works in riscv qemu
> > land.  So I'm asking.. :)
> >
> 
> There are no migration compatibility guarantees for an unversioned
> machine type. Only migration and snapshots from same-version QEMUs are
> expected to work in this case. Other scenarios may or may not work.
> 
> >  From what I understand, migration should fail when the target qemu
> > has different set of properties compared to the current one, - no?
> >
> 
> The addition from this patch is in a subsection, so .needed will
> determine whether it will be put on the stream. If we backport the
> change, then the stable QEMU build will (likely) start sending this
> subsection, which the old, non-stable QEMU will not recognize and
> migration will fail. Migration from stable-stable would likely work.
> 
> So any stable versions that (would) contain this patch are likely to
> block migration from that version into an unpatched QEMU.
> 
> Note that since the machine is unversioned, migration from QEMU x to
> QEMU x+1 is already prone to being broken.
> 
> > But if it works, we should apply this patch to older/stable releases,
> > there should be no issues in there.
> >
> > But again, I don't understand the mechanism here.
> >
> > I'm adding Peter and Fabiano to Cc (maintainers of the migration code),
> > -- can you clarify please?
> >
> 
> @Peter, I hope I got it right, feel free to correct me.

Agreed with above.

If riscv cares about migration compatibilities and the ability to upgrade
clusters without interrupting VMs, maybe it's a good idea to start thinking
about versioning the machines.

Tkanks,

-- 
Peter Xu



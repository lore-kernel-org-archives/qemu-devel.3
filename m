Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C3DC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dpn-000742-Bt; Thu, 10 Sep 2026 08:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4dpl-00073D-Ko
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4dpk-0008CR-4I
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789043089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6a0Pe3G/lasgaVjH9i/P7lUjc/+dB4YQzMPz1WODYOc=;
 b=WFcTZUP+895zW/KpeEuY7g7IRb/wabaObCSHf6qglxZnDC7E7EMf1ub1m03XceDqYYuJjk
 HjJ54EW2bUYfWkgPMRl7KQIEX0tTFh/nib05l1MnZM2InJFaMEgiJcRMS+2ZGzc0HYm2hX
 iCK+pT9FL3mNnV0EQyKrahVLGWStb04=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-T7tRerfMNQKP_Si8-8vOEg-1; Thu, 10 Sep 2026 08:24:48 -0400
X-MC-Unique: T7tRerfMNQKP_Si8-8vOEg-1
X-Mimecast-MFC-AGG-ID: T7tRerfMNQKP_Si8-8vOEg_1789043088
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e87478402so101308206d6.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789043088; x=1789647888; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6a0Pe3G/lasgaVjH9i/P7lUjc/+dB4YQzMPz1WODYOc=;
 b=R6D3sPXTbLXlrtNU0Ize5+dqdR1oGqLbqtiWi6MN9m7DIxQF9uHHAfgQvjblkuS97K
 JB/jL3dvXJW9YgL/AzEovWpeR7DXAJmlTItFEhyPd34BwjKWL0kOaoOByeWofGLBHGk7
 mNoslZBItTSnVIq/Yv1QrHHdry3WRVksJpHmqaSsGea7RuPOPYOlW5R13Ys89Dbc2aNx
 qWTWV+c+v+LTIvMUevmVd741R05moLqmOuJDbLr2cE+fZ7wwlrtRb1Cg7QXLepLvFEpT
 ndRazzS7AL3JWSWY2I72ZdtO86J/ZAYwwHc1mIYUKOdCz0le3nmGRd041yNFBvO91LL0
 I3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789043088; x=1789647888;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6a0Pe3G/lasgaVjH9i/P7lUjc/+dB4YQzMPz1WODYOc=;
 b=Dw5kDh6u354+vN0VZmGgB/MByorwV6GIRMCeS16GdNTHOFBpzYqFs6Hf5DOTP2dHPv
 zQIYlMNNDb6CYBxwcKnfV41M3d3uwSg9XS0lvsuu7v7oSMv76Fu3nCvJJk7cRDbjL6To
 Hf7MTSWa0Ddbo6cdVsVF06kIM6Do2TSSdfZ8M5gyaUw9Q+rlHbA5YsXUv4DCvwcMVklW
 47U5s6LnmOnGSTVa/f3AsUBBiZfo3GLCfmiIBUg9UIYNZQs2G1wFT5MrP9KeV7wfMHtw
 MvefoPEGj3ZJkK9O/tQjfiIblNzpxw4+1WzWsIRrxNf4j9WhUhpJtbPW9BiwFT3oUc5T
 tXtw==
X-Gm-Message-State: AFuF++kA/XP7fDhW/p+7FryIHFQnQglCeKVuwGZ3ZEqrVB7tE9+8W2gr
 V+PGfBBg+ubZRehEeb8ruHjev9s8iA86gfXWLkq6o6d6OpB061nLs7npXLIO6wUDMLENdxA0LPh
 K2dvYEeLnaUZ7RZjQIG0QuEcAaQHcwTgzJR12iAduS1v9QJz1TZUfpI+o
X-Gm-Gg: AYBFou3Z4BhvA8TL3Rs/zfr/5PcAcuCMFDalp4VsqWy4KVtjJmm6HYcURLDAuetB3wU
 JBxD4Uw8H5faf9y8bI+3YqdCmHAottT3bobXJ0JShQz7kxvB3pmnDsp9w3XWKUO4IwDPe8UkUd0
 6298Oajx2wZJiVPuB/8HQsd8gfHe6kqb74x/gWDRm+mqb5CV+u8TrkZndWAYAtB2ApCRU1nASoq
 MXaTfKVk59HjvKwF9gF3FREf9p2VqbhpUPwf+kUaZIQepr8eSv0KLa5CJYHWsVSDBogzA3o8TZI
 6Sf0wb6uEqBFM7EJkb3rT2IvkOXcY3BBWrU2iN+V1S+DeU9ogzNEJzjcxpEnvKn+g4iV
X-Received: by 2002:a05:6214:2269:b0:910:4a2e:8c8c with SMTP id
 6a1803df08f44-9104a2e9178mr408164126d6.17.1789043087943; 
 Thu, 10 Sep 2026 05:24:47 -0700 (PDT)
X-Received: by 2002:a05:6214:2269:b0:910:4a2e:8c8c with SMTP id
 6a1803df08f44-9104a2e9178mr408163536d6.17.1789043087404; 
 Thu, 10 Sep 2026 05:24:47 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9104fc73ea5sm121532606d6.39.2026.09.10.05.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:24:46 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:24:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/3] migration: Free the JSON writer during snapshots
Message-ID: <aqKhg8WtiOW8YkDl@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909221409.291560-1-farosas@suse.de>
 <20260909221409.291560-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909221409.291560-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 09, 2026 at 07:14:09PM -0300, Fabiano Rosas wrote:
> The JSON writer is created at migrate_init() and freed at
> migration_cleanup(). The latter is not called for snapshots. Add a
> call to migration_cleanup_json_writer() to make sure it doesn't leak:
> 
> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x55ca12aabca0 in malloc
>     #1 0x7fd97d7e595d in g_malloc
>     #2 0x7fd97d7ffe38 in g_slice_alloc
>     #3 0x7fd97d8042e2 in g_string_sized_new
>     #4 0x55ca1571dd6b in json_writer_new ../qobject/json-writer.c:36:24
>     #5 0x55ca12e0de56 in migrate_init ../migration/migration.c:1718:21
>     #6 0x55ca12ec8fe6 in qemu_savevm_state ../migration/savevm.c:1921:11
>     #7 0x55ca12ec8b93 in save_snapshot ../migration/savevm.c:3380:11
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



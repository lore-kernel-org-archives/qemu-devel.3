Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0AEC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuVo-0000pm-7l; Thu, 11 Jul 2024 10:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRuVg-0000iq-TO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRuVS-0001wF-Nt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720707044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kg6YI+tdXJr4G0sK7LxsqNkFqHQH9QafGK93PzELlk8=;
 b=NZhAmRTJ4YvAyEPjlzzD41+p3Idotl0Xl2hAQTvi+rp7RqO62LAHhOGXMrxRVVN3GQ30TB
 yenq9JnPJAfSDS7gE3rv180KfYYQeruQeWARuHqHtz05zRk5ruJEJCuLcDTlwGerxBsqjT
 z6XSsecBrffmzs0Nb62gg/NC7pi+WII=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Hl_uQJFeNWe8r1QTDXUg4A-1; Thu, 11 Jul 2024 10:10:43 -0400
X-MC-Unique: Hl_uQJFeNWe8r1QTDXUg4A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-448335bb53aso414141cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707043; x=1721311843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg6YI+tdXJr4G0sK7LxsqNkFqHQH9QafGK93PzELlk8=;
 b=Iz2cZLmOnAppl1oJSEfClDGHTVhMvKwuX9NT17QufalRoHcHMeVv0eDlDZj/OkGY6J
 1RwlfqNfM8Z59hfgia8HcVIyXjQEq3Jo+eRKoLrsbnj6+3V1ueXo5TEZmEixd4C7XudN
 RjoMMeHFr4OJ6U82THTFH3KD13sSja0bLqdiFCrUkiKBze3UtAwi+f0PyO7EvGVs5a4j
 omfz1d4iB/fqT78ZZUQlptobqCD2h/+667BLVQKGw6bYMYrfVbjvrGIwAYj5lgIWqAoX
 XZiJcJMoi9wrNyiefRRi5U5UBi6+z15ZFDrhgtcqsXGxzZQ/yqcuCcEl45NE52fmkiva
 WH8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkUcHImgupjykl37uN6KOOPWlcfFBEZ1fETAtKIzaVtUGOQaR3KmeydBYaitikgPRA9ePPVYSfeTSxQJXittlpkiIVM4g=
X-Gm-Message-State: AOJu0Ywg6nI+qV0ktT6IjgfjwjbxneL3sBT6Q3sJLAkqZk51cKCSj40L
 WtTm5CjKWzyGIKr1i1wsQ22fogDO50U7nWiuSE6owz2n8SYHWK02uv4rRXqLmpTjq54TwgSHQBZ
 b0xMGN9x92SJaG/lTe7VfJXbBar1R+cAfI9N8H25qSHok6P9pyf8I
X-Received: by 2002:ac8:7354:0:b0:446:5d1b:5a2e with SMTP id
 d75a77b69052e-44cfec95b95mr23089951cf.5.1720707042809; 
 Thu, 11 Jul 2024 07:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL2LcJsHtMl2g4W/Ij3JD700G0cKe3RqkTzKqUCMCnYewUiAODv00Ek0NO6uKZepI1YLqmpw==
X-Received: by 2002:ac8:7354:0:b0:446:5d1b:5a2e with SMTP id
 d75a77b69052e-44cfec95b95mr23089491cf.5.1720707042290; 
 Thu, 11 Jul 2024 07:10:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9bd2b54sm30383341cf.63.2024.07.11.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:10:41 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:10:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, devel@lists.libvirt.org,
 Luc Michel <luc.michel@amd.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Message-ID: <Zo_n39Vusyy-O_48@x1n>
References: <Zo2lLLAwcZ8bBvO2@x1n> <87a5ipfigb.fsf@suse.de>
 <Zo6iZjc8YpI1_9dW@x1n> <874j8xfc9s.fsf@suse.de>
 <Zo7dcF8OKfH92RlR@x1n> <871q41f2pk.fsf@suse.de>
 <Zo7rCXtap2lWd4IB@x1n> <87ttgxdj1p.fsf@suse.de>
 <Zo8F4Gq4f7SawaDc@x1n> <87plrkdpd7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plrkdpd7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 11, 2024 at 10:34:12AM -0300, Fabiano Rosas wrote:
> Is there an easy way to look at a field and tell in which machine type's
> timeframe it was introduced?

I am not aware of any.

> If the machine type of that era has been removed, then the field is free
> to go as well. I'd prefer if we had a hard link instead of just counting
> years. Maybe we should to that mapping at the machine deprecation time?
> As in, "look at the unused fields introduced in that timeframe and mark
> them free".

We can do that, but depending on how easy it would be. That can be an
overkill to me if it's non-trivial.  When it becomes complicated, I'd
rather make machine compat property easier to use so we always stick with
that.  Currently it's not as easy to use.

Maybe we shouldn't make it a common rule to let people reuse the UNUSED
fields, even if in this case it's probably fine?

E.g. I don't think it's a huge deal to keep all UNUSED fields forever -
sending 512B zeros for only one specific device isn't an issue even if kept
forever.

If "over 6 years" would be okay and simple enough, then maybe we can stick
with that (and only if people would like to reuse a field and ask; that's
after all not required..).  If more than that I doubt whether we should
spend time working on covering all the fields.

-- 
Peter Xu



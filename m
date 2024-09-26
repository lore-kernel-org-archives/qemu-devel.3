Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2A1CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 08:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjcS-0002HF-TT; Thu, 26 Sep 2024 04:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1stjcR-0002GA-0s
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1stjcP-0001UQ-FZ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 04:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727338375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhmmk+HNQNZJx5GhoT8w8Y3Cc0bUO8RkXaEz+sTGI70=;
 b=ElRam0vIIjMtEamLCVK3jS4d8OPSGuBURf8FAnVl+KFXPdHoE8SR6/sZg68LdWy/ggV4Yu
 aOTnFdg62t4mNmpbLQNPHSUZsNns564Vu1fzI4M1TsR81otsITPiA7faoPYXeiCE7lCqSE
 pVNjr799RxspEBj4FPSOV/mramMbzME=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-ZesbwFKhP8mI5sGVmWeybw-1; Thu, 26 Sep 2024 04:12:54 -0400
X-MC-Unique: ZesbwFKhP8mI5sGVmWeybw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37ccbb420a9so364503f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 01:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727338373; x=1727943173;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhmmk+HNQNZJx5GhoT8w8Y3Cc0bUO8RkXaEz+sTGI70=;
 b=DmIxGFFFQ/7yi73aFfI27e7jw20dxr+8bS9wzl+rYhgRPcCAQtWXM5HY5C3829+h5e
 XT5jhK5MApVCtonM4KvKwfG3QH6fpjRMmDvX4/Q8XMcTLMg/ml0tD9S8EuojSRhSNLYv
 fwfumyxUm0YGU10PnpkSHIY0NYzsdUIRKjs0cNVa1+JDPT3yqBOgGjqFxW+Ync4QAkf7
 enADDcoW4zynUoGiOwPSnkqrq7oNF6g044RLskjFMCrmL2yoncHmOfMql4wWNtjPtQmN
 V7NpYOFagytSKalG7d3J8MB+jJOup8RC8eK/J2tgF26e3h+edRILlYQXu6YjAXi02xyt
 jZZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrvyv0iuumVIWLsk9t6j6BDVqBE9R11bMMeqH1KdDRu0lI/7tMR7NC+HNP3xfJfnvjpgHmkV7jNfWs@nongnu.org
X-Gm-Message-State: AOJu0Yzm31zl96yZw8F2GLEOZKr6kscsO2Ggm85mgIbf+xLG1e4weAdG
 FUDnrRPVveMwbe5Pyi2ZZYHw9iU5Qgb1EwgtTb1Pyh4rMy+pHCnnpSLrAUrIACwaR6yelssbfSY
 j92EVV+IR7aKIUTGKtYFYE8kPGe65beSaVCz/MWGDCmNePKYMHj6P
X-Received: by 2002:a5d:4803:0:b0:374:b97b:c69 with SMTP id
 ffacd0b85a97d-37cc24d0616mr3577784f8f.48.1727338373067; 
 Thu, 26 Sep 2024 01:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHonMeVeIPGb6VKEESWuUwzrWEEL1jEAz3pAxX8XYL5AkJ3w8xxJKew2qRYHOAXk6F9wkOW5Q==
X-Received: by 2002:a5d:4803:0:b0:374:b97b:c69 with SMTP id
 ffacd0b85a97d-37cc24d0616mr3577738f8f.48.1727338372581; 
 Thu, 26 Sep 2024 01:12:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:1ead:3828:4c0c:a50:df14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc3187a4sm5778853f8f.90.2024.09.26.01.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:12:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 04:12:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] softmmu: Support concurrent bounce buffers
Message-ID: <20240926040912-mutt-send-email-mst@kernel.org>
References: <20240819135455.2957406-1-mnissler@rivosinc.com>
 <6c94975d-2c8e-4698-a035-1e62549c2d4a@tls.msk.ru>
 <CAGNS4Tbw_JSfzyir2TKBN59n6jkrerGoy6E9hEW8xcq0y3tO4w@mail.gmail.com>
 <3761eb6d-89c0-4e73-baf6-9242ad5136f7@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3761eb6d-89c0-4e73-baf6-9242ad5136f7@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 26, 2024 at 10:58:57AM +0300, Michael Tokarev wrote:
> 25.09.2024 13:23, Mattias Nissler wrote:
> > On Wed, Sep 25, 2024 at 12:03 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> ..
> > > So, the issue has now become CVE-2024-8612 (information leak), with this
> > > commit (v9.1.0-134-g637b0aa139) being the fix.
> > 
> > Interesting. IIUC, this is triggered by device implementations calling
> > dma_memory_unmap with an incorrect size parameter as provided by a
> > hostile guest. Shouldn't the device implementations be fixed to
> > validate the parameter as well? Maybe this has already happened? It
> > would seem the more targeted fix to me.
> 
> Yes, a similar question occurred to me too, - this change does not look
> like a proper fix for CVE-2024-8612.  And nope, no other changes has been
> made to fix it properly, in the device implementations.
> 
> Maybe now with CVE-2024-8612 in place, we can fix the actual problem in
> the right place, instead of relying on this change..
> 
> > > Should we back-port it to previous stable releases of qemu?
> > > (it applies to 9.1 but not to 9.0, and I haven't tested it even in 9.1.
> > > If anything it needs some work for 9.0 and before)
> > 
> > FWIW, I've been running with earlier variants of this since at least
> > 8.0.50, so a backport shouldn't be hard. Note that if we decide to
> > backport, we should also include "mac_dbdma: Remove leftover
> > `dma_memory_unmap` calls", which fixes a bug uncovered in mac_dbdma
> > uncovered by the concurrent bounce buffers change.
> 
> So far I picked this and mac_dbdma change for 9.1, and will try to
> back-port things up to 8.2.  But it is better - IMHO - to have a real,
> more targetting, fix for CVE-2024-8612.

Agree 100% here.

Cc a bunch more people involved.


> Thanks,
> 
> /mjt



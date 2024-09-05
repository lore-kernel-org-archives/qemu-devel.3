Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A42FCD8CBD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 17:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smGJu-0005mp-Il; Thu, 05 Sep 2024 13:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smGJs-0005lv-Oi
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 13:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smGJr-0002sP-84
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 13:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725557453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9O1Qe/YH4D5YxssUd0lvMkBAFLFZ6/2Lxawst3MRUfg=;
 b=RBx/I+SPZUXsNzo4jX2K8z2ajM8R/Wa45WN35zgqK3UcZtFIQDUidTn70v4G7bxJ4p2emC
 9kbZWeeL8kmJui1LeyghaNcujZvQo0VUuMORlUl+hoqURd8zAEE6pZ1qcbrmCuH711XXzK
 tNqu6t/SnOGej+0t8OqjAEXDe/gPaWs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-BN-hmB7eNKKjylDdBXtXOg-1; Thu, 05 Sep 2024 13:30:52 -0400
X-MC-Unique: BN-hmB7eNKKjylDdBXtXOg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3df210363cfso1206396b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 10:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725557451; x=1726162251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9O1Qe/YH4D5YxssUd0lvMkBAFLFZ6/2Lxawst3MRUfg=;
 b=VQOuFblnnH3fiC+CSfHQUGpQRHT6DMIVZJcy2OV+i4A5oHgsVVJMb4EMCzQv7cEYJD
 H3H+NRDjVIPIqO4jxp5UeBj85XTyfZhI3fL85CHi8s/ADoyW6nviWT+7sQvYlZY4udZ/
 BXPFfcw8Ys7Eo/XHxfXwHtAbnhzEFsmj4Ou/yEZ8uPfHWvmqgByimZRkMMzULJtxy7B6
 bfrhyIDsyvd2rcpoN+9SMH00cVz5lFVkWePKK9jctOSe1RNBExHyvYLxavakmJ58Pgau
 NHdYlXm82JZykHKi3Kp63Gvxv1AvIBqUqRLR2zcW4qot/gWYH37Q40j5m0ZP7caF+nIH
 DL+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGp2sz87hf3OhssGFgZO6lej/Le1GQwZjXsTRlC6EB53fkaKcWUYbLBu1OaoDSxbGMCS8o1qNwYjsH@nongnu.org
X-Gm-Message-State: AOJu0Yxculw+JldyuL55mIVzm3Aab8nQWZnwksWxNhKWW3xRU775De5r
 /rZTSJckr7JfW8kPxVAB0dZ2G256KilfWWnim8b/pzeu37rQqgztKapd/815ZaaIsTEVIm8+jHh
 LP1tHpWYmYGzX7kjq8Wa4BeuxlsMLkONcNfLhM9CWJT7ykxs35vWc
X-Received: by 2002:a05:6808:2f0b:b0:3db:209e:7222 with SMTP id
 5614622812f47-3e029d02cc9mr35668b6e.15.1725557451701; 
 Thu, 05 Sep 2024 10:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCTrt73Zp1gcVgrRxFgqJwXZARlufYoO/5NouyYTHWfbS9s6bsG/6XMkjt62A/+gFmp2Zzug==
X-Received: by 2002:a05:6808:2f0b:b0:3db:209e:7222 with SMTP id
 5614622812f47-3e029d02cc9mr35641b6e.15.1725557451351; 
 Thu, 05 Sep 2024 10:30:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b31e67sm8847131cf.21.2024.09.05.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 10:30:50 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:30:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <ZtnqyXJozm87sy9_@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
 <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com>
 <Zr93bOr1zrSZadf5@x1n>
 <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
 <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 20, 2024 at 12:29:07PM -0400, Steven Sistare wrote:
> I still go back to my original statement: -incoming-cpr  has equal or greater
> "specification complexity" than -cpr-uri.  It is not simpler, and comes with
> restrictions.

I'm ok with it, as long as Dan and others are ok.  I remember I should have
copied Paolo but I didn't see him in the loop, do it again.

Some context: it's about introducing yet another qemu cmdline for
cpr-transfer to specify a URI port for early stage loading of QEMU internal
stuff, which Dan raised concern on going against managing the VM using QMP
only and removing cmdline efforts.

For a generic follow up to yesterday's email: I was trying to re-read the
thread but I found that there can be a lot changes, so I figured maybe I
should wait for the new version.  IOW nothing else I can think of yet to
comment on the series.

Thanks,

-- 
Peter Xu



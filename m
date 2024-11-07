Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC592D5D674
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 17:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t96cq-0000YJ-9M; Thu, 07 Nov 2024 12:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t96co-0000Y8-9X
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:48:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t96cm-0000W2-Lq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 12:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731001731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R3Dtbj/Pdv+/aqhBNadhGaq0Rc9Mc6c2BCVdkN56TDU=;
 b=ivJgMMtq0H0Hm/ktAiYOYPfcXDUOXH1t3SC7FgUdX6Ydra14LO7Yc5rlCM1ltHQRSGOykw
 JeyQcjDY/6VbH4nOoKvfYwGGuE3iBu21XlYaXDiX6ZSzVt/3u6Nwp3hZ3m2GSRxGRZQQA1
 DBAjwFP/jAnZSif8aceac+SOhY0Bi20=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-v6cYBZf5OMa9Cdh-nOnjNw-1; Thu, 07 Nov 2024 12:48:50 -0500
X-MC-Unique: v6cYBZf5OMa9Cdh-nOnjNw-1
X-Mimecast-MFC-AGG-ID: v6cYBZf5OMa9Cdh-nOnjNw
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-71816436594so929776a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 09:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731001730; x=1731606530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3Dtbj/Pdv+/aqhBNadhGaq0Rc9Mc6c2BCVdkN56TDU=;
 b=NCXiiUi0MOB6p3SMZG6mQM25+9YF7Lz+myRIVssWFnVFiQCcTbj+JOUf9q/cfsexmS
 MF9RjfjeN1O4d/mY6riLqirHwdDVbOTJKtBHxhxz5vtOeI62FkoVeb9OwoRsxZJUkM6v
 nsNHXDyqmSSwKG1AdkRvcGTNDHhr9PMvy1aoeCVyIXTiso8L7uV2mRagVPK4zxhr31Yx
 DFT/AXYW78hu8u4tgBxRc0mOojTbQUUI4StZTN1BPTevKIjGW5A6g5djfokFR1oGTSZh
 O1bhzK72npYiJviN3o4NrbewJSWAFHlmuGhJ1TQLBnGmcsmCD4pdPIPWeJjnybwk72CD
 VF+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO1k/0o3RByErtrMTjxnmC4RoTRUQ2AChvdWzbULwiTK1ID6fHXC4hN9I2UTTivhuSvKgchTu3U5tH@nongnu.org
X-Gm-Message-State: AOJu0YwJHePmEO/ElFlukcP7KscdC4WAuKEZZnqsd5TJwr1dwQR2z8Lg
 Ne719JeI1ZXBNmDF2VDiGep3mPCuc8TeLckkPxCjs3zf1QzNFAdCzIUMkASr4JGtazjdmC+E602
 nddDu++1nRw0fJ4IPRZI78OqRwOoKUo3Yc1pdBTi25XV8+K9Ikx4m
X-Received: by 2002:a05:6830:3917:b0:709:41c4:6a5 with SMTP id
 46e09a7af769-71a1b0196c3mr301571a34.3.1731001730082; 
 Thu, 07 Nov 2024 09:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrh4MYjB/LbDVhhQaWtwd76kU6W33REjpkdVZs7MU6Lq6AD/DBloOz7f0qsMmNzvAoyigbqQ==
X-Received: by 2002:a05:6830:3917:b0:709:41c4:6a5 with SMTP id
 46e09a7af769-71a1b0196c3mr301558a34.3.1731001729837; 
 Thu, 07 Nov 2024 09:48:49 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a10836317sm355726a34.35.2024.11.07.09.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 09:48:48 -0800 (PST)
Date: Thu, 7 Nov 2024 12:48:46 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zyz9fj3fUnP_Ni5f@x1n>
References: <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <ZyvUg3CP30f3DZYY@x1n>
 <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
 <7fb32744-0512-46e2-b58d-2990f742b897@redhat.com>
 <bb324f6d-8c8b-4f92-9c0f-12278e3c926c@oracle.com>
 <ZyzrqnqoK81QfT_c@x1n>
 <db8fe7a8-9592-42b4-a7e2-df9575408c71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db8fe7a8-9592-42b4-a7e2-df9575408c71@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Nov 07, 2024 at 05:38:26PM +0100, David Hildenbrand wrote:
> > David: why do we need to drop PRIVATE in ramblock flags?  I thought it was
> > pretty harmless.  I suppose things like qemu_ram_is_shared() will even keep
> > working as before?
> > 
> > It looks ok to remove it too, but it adds logics that doesn't seem
> > necessary to me, so just to double check if I missed something..
> 
> A finished ramblock is only boolean "shared" vs. "not shared/private". A
> single flag (RAM_SHARED) can express that clearly.
> 
> Consequently there is less to get wrong when using RAM_PRIVATE only as a
> flag to the creation function (and documenting that!).
> 
> To make RAM_PRIVATE consistent we might have to tweak all other RAMBlock
> creation functions to set RAM_PRIVATE in the !RAM_SHARED case, and I don't
> think that is wroth the trouble.

Yeah, I actually prefer PRIVATE to be applied everywhere, and assert that
either SHARED|PRIVATE be set in all ramblocks.

But no strong opinions, if both of you like it only applied optionally, I
already lost the vote.  But yes, please in that case extremely carefully
document PRIVATE as it can be very tricky now.

PS: when I think about how to document that, I really, really hoped we
simply apply it to all..

Thanks,

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0A9C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTu5-0002lY-W1; Thu, 18 Jul 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTu4-0002hn-Uk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUTu2-0000UF-1v
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 12:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721319764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbt3Vb1ZpOulrrGC/ee5PphT13OUYnoR3heUaMrKpcg=;
 b=IomZx4QPH1Dhx9abggFVDAbqCAvuN4Di3tjj/KUt//tig09FlTD9YlwtTMPhzqwB6mhbGE
 ba0pEONr3thqyGtlGvVjK5EI6mSO23TgzbU7+sYsXNEA85Qxv+1xzg7n1zuN+Eh/vpwxos
 /BejYl5gTf/PPJ3mEbpQP+coX7DHNZE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-6LKhXtnKNKOML382rKGQVQ-1; Thu, 18 Jul 2024 12:22:43 -0400
X-MC-Unique: 6LKhXtnKNKOML382rKGQVQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b7678caf7dso3009186d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 09:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721319763; x=1721924563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbt3Vb1ZpOulrrGC/ee5PphT13OUYnoR3heUaMrKpcg=;
 b=nYdQ/Iofg6t5ohOhWeI4MXXR35NT+iq7PQXxFPC29auLdYTxGWIpv7+QFRdNGxoJNO
 vVBM1DoFD4OEJ0PKQKd7zR5Xj9JQuQduXhldp9J0ujh6Ejd0VfldNqA3Ixrlp0V8Hd0a
 RlpDM+itCz/Q/P66atTRMulH9EvlNbC8zFpRr4b9NBrDtuudJ3sTYrGkNhfjxDWvQ0/+
 0mKUcQypYWKTXFbzNgJ8GXoVpDr51Adg8bZvLxBQqzpNgN0Cx+iE+JkwTavhSxxZL6+K
 F5sHyq6eROclLEXBwjSy0gqLmJpYGYayggS6Nn9Ajg9bcQVw8QH/cDJPFL5N8b6g+Xvz
 I73A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwB0ZkfG6kjWiHr3cE4j7USgJIa2FFlgH80Jxw838fGUblGbeKGMJm7nyGo2NKT8sz+oewIwyQOTh8QIvwaDDURFneGfs=
X-Gm-Message-State: AOJu0Ywg+jTdHuyPoj3p7O03Gy11248+i6yEVofTncIBTN0tRiSpf6Qc
 ELYUiHua8ZwsPHSaC0uQWqXnUVGGQZGwgw6j+9YDy0ucwVic3S541KV6zbcSklXDN/0XErZhb7S
 bKa3JaSfEnppsVilDQkSe38TnwcrChA6ENX/gm5HyAPU0zzPyHcz5
X-Received: by 2002:a05:6214:310a:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6b7a8e5192dmr406716d6.0.1721319763228; 
 Thu, 18 Jul 2024 09:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmTXU4MkmYW0di2V1ykNjbw0qx42mrE9HIuncKKPZmbn57aD7ViCzXTwRW6m2qIbQdKrq1Gw==
X-Received: by 2002:a05:6214:310a:b0:6aa:3158:e8c9 with SMTP id
 6a1803df08f44-6b7a8e5192dmr406556d6.0.1721319762882; 
 Thu, 18 Jul 2024 09:22:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c51805esm9440046d6.66.2024.07.18.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 09:22:42 -0700 (PDT)
Date: Thu, 18 Jul 2024 12:22:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <ZplBT8iVkkPZ_DGI@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <ZpgaZPxKzwcVAYZn@x1n>
 <7d37a745-6463-4b43-979f-2ac635f11d11@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d37a745-6463-4b43-979f-2ac635f11d11@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 18, 2024 at 11:43:54AM -0400, Steven Sistare wrote:
> On 7/17/2024 3:24 PM, Peter Xu wrote:
> [...]
> > 
> > PS to Steve: and I think I left tons of other comments in previous version
> > outside this patch too, but I don't think they're fully discussed when this
> > series was sent.  I can re-read the series again, but I don't think it'll
> > work out if we keep skipping discussions..
> 
> Hi Peter, let me address this part first, because I don't want you to think
> that I ignored your questions and concerns.  This V2 series tries to address
> them.  The change log was intended to be my response, rather than responding
> to each open question individually, but let me try again here with more detail.
> I apologize if I don't summarize your concerns correctly or completely.
> 
> issue: discomfort with exec. why is it needed?
> response: exec is just a transport mechanism to send fd's to new qemu.
>   I refactored to separate core patches from exec-specific patches, submitted
>   cpr-transfer patches to illustrate a non-exec method, and provided reasons
>   why one vs the other would be desirable in the commit messages and cover
>   letter.
> 
> issue: why do we need to preserve the ramblock fields and make them available
>   prior to object creation?
> response.  we don't need to preserve all of them, and we only need fd prior
>   to object creation, so I deleted the precreate, factory, and named object
>   patches, and added CprState to preserve fd's. used_length arrives in the
>   normal migration stream.  max_length is recovered from the mfd using lseek.
> 
> issue: the series is too large, with too much change.
> response: in addition to the deletions mentioned above, I simplified the
>   functionality and tossed out style patches and nice-to-haves, so we can
>   focus on core functionality.  V2 is much smaller.
> 
> issue: memfd_create option is oddly expressed and hard to understand.
> response: I redefined the option, deleted all the stylistic ramblock patches
>   to lay its workings bare, and explicitly documented its affect on all types
>   of memory in the commit messages and qapi documentation.
> 
> issue: no need to preserve blocks like ROM for DMA (with memfd_create).
>   Blocks that must be preserved should be surfaced to the user as objects.
> response: I disagree, and will continue that conversation in this email thread.
> 
> issue: how will vfio be handled?
> response: I submitted the vfio patches (non-trivial, because first I had to
>   rework them without using precreate vmstate).
> 
> issue: how will fd's be preserved for chardevs?
> response: via cpr_save_fd, CprState, and cpr_load_fd at device creation time,
>   in each device's creation function, just like vfio.  Those primitives are
>   defined in this V2 series.

Thanks for the answers.  I think I'll need to read more into the patches in
the next few days; it looks like I'll get more answers from there.

I just sent an email probably when you're drafting this one.. it may has
some questions that may not be covered here.

I think a major issue with exec() is the (1-3) steps that I mentioned there
that needs to run sequentially, and IIUC all these steps can be completely
avoided in cpr-transfer, and it may matter a lot in huge VMs.  But maybe I
missed something.

Please have a look there.

-- 
Peter Xu



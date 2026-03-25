Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F01C109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5U3Y-0000MK-Fs; Wed, 25 Mar 2026 15:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5U3W-0000LH-WA
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5U3V-0003dF-5e
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774467495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0fa4VirsDWak1lQL6RVXUez7ROiMTb2N4mv2Ue8vlg=;
 b=QFfEkaYAwZtWguAxIF3DzeLsqb4b7t67UjYUM76H8ikGMKcktreciWF4l0EkD71j2Tirn+
 zIXQLFzdMh7d+lINwQ9pWxD0hJz5yDwauaA8V3IUIPizEFStjXdFbPZ0q7lV9gvkE5g59G
 dhrYKFkdjdhznF8oS2b0SFuQsjcTx/k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-PZ96KR8WNPe1okr0wjLQmw-1; Wed, 25 Mar 2026 15:38:14 -0400
X-MC-Unique: PZ96KR8WNPe1okr0wjLQmw-1
X-Mimecast-MFC-AGG-ID: PZ96KR8WNPe1okr0wjLQmw_1774467493
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd77e5e187so89233785a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774467493; x=1775072293; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o0fa4VirsDWak1lQL6RVXUez7ROiMTb2N4mv2Ue8vlg=;
 b=OZXeTYphc87+XDasopzt6ZPwr+4cPn0hTd7oAioC8r0YX89IVLML7NElfuDq01LuFx
 g06JzOEe4FpXTxLKj/nSowUxYVoDCVWScEbWUNtTUk/ZA2KryIYvHNdCI707lWdvGJUz
 LsosHuwmQl112OvTePxDPEK6fdeawfNey2ArU4oI60cVghLaSayfUADlJ/rbO4esZFVp
 6T55VLG5TDbMd0eHTSui6pNPDDONKdtPSw4HWViFXatzxoFFS29nR3Akzo+2LaPC9hle
 t14CPzta93EuSDy8paE//QKWzwGRkkooThImgCxPgnn7YdTyzwSkoEtoI0YFkd88FX6/
 i9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774467493; x=1775072293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0fa4VirsDWak1lQL6RVXUez7ROiMTb2N4mv2Ue8vlg=;
 b=qZsB9hvLC9yw0J9mI0QwZjAlfWU+iGDSIUo5iy8AKkAt5+uSAzOKEXJfrpogSFJbrc
 WBxvQDmi4Hp+hxCF5dMpVt6CC8MUr82kDYnKfWFmqavs2U4EU4S6OgC/gIencohwpoD/
 2gxzTdiMvoemFtSZtq062REQVtLoxwnqOWQ8CKJRshn+Xn3PXAZect8qkUMREmz+/l3P
 hCZAMSlA/ubv0DqANG5RXUQv2tmBVWElSattF39X9/gpLv6vx3F2OA9aL1KIDO896u71
 KkZ0siJbVFVq2oHDIqHn6la60YYF8PHHsGOE6euGmaTGzKKndglId37uJPxv8AHP+t5g
 X2Bw==
X-Gm-Message-State: AOJu0Yw+LiqKyWdMzwhwe8CPywNnEBWhi/iDzcDS5B0wwk2xnJtUC1Xi
 zVdQTaodz3LvbqNmc6TaniqDQCHGjp/NHWFH0D1yEe+qJLIBod5aO5F7SmcSqPDWaFEPsQKUwx8
 9TjSg4LoMr26ZpsrhJDHPObM8uXVah4FKgD7TPnF4ffDITlv/lO9Xiylu
X-Gm-Gg: ATEYQzyJXZsaZ4vE8qUQpnl4boqxHxc8qgSMFyEbLEGAe/kEpWCNyDtYZZJ6flYZaX+
 nv6bj5J3qlJz4We/thCnEJI4YgKgYAN/LvdMio230KVa0kKlZGB47g+B4GHhfo/uyKABFBTSemk
 CK84IqJSLCOEvV0pm4232Mxzz1qpYqorNhpYcybsG/Plsfw8ap3Itudq7J1EFz9lhXOjC5D7M6Z
 nw88QOLwO6Hx456pqd0Cgdatc3wcPR2ZLf+a9qYM59xU/UIEhEIMBwoW9hjIgaIrlp8FHyjHnKE
 wZmOW304AhRmH2oW273pqGPHzzci0yRF190pCKcfbseuhH+g5KE8RHh5vF5hTFryXiHFA+Xztqi
 qNAknUctRTr2Fzw==
X-Received: by 2002:a05:620a:29cf:b0:8cd:c01f:fd25 with SMTP id
 af79cd13be357-8d000f1731amr622643585a.14.1774467493214; 
 Wed, 25 Mar 2026 12:38:13 -0700 (PDT)
X-Received: by 2002:a05:620a:29cf:b0:8cd:c01f:fd25 with SMTP id
 af79cd13be357-8d000f1731amr622638985a.14.1774467492515; 
 Wed, 25 Mar 2026 12:38:12 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e3d656fsm61848785a.17.2026.03.25.12.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:38:11 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:38:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 14/17] vmstate: Move VMS_MUST_EXIST check
Message-ID: <acQ5ouzMoFNoVouH@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-15-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-15-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 04:43:29PM -0300, Fabiano Rosas wrote:
> Move the VMS_MUST_EXIST check into the vmstate_field_exists() function
> and make it return bool + errp. This deduplicates a bit of code
> between save and load.
> 
> XXX: why do we assert on save?

I don't see a good reason to do that.

OTOH, I have a todo to remove VMS_MUST_EXIST, it can always be done by
pre_save() or post_load() hooks, afaict..

-- 
Peter Xu



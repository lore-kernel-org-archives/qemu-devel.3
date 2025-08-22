Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D1CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 07:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upMSm-0003ze-6l; Fri, 22 Aug 2025 03:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1upMSj-0003zG-3a
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1upMSf-0000UU-Ur
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 03:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755848715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOvxBdRk8WyLBY2AJPQXTToCw81ShQ+fO0Sw+/AFfP4=;
 b=Ic3xC4R5jXr5y87rJ599S62BloEJKjsKAt0mjk9NyR8uCd0yXb1TLMjD3r9waFHKJ9KF6N
 8jhK/fme743S1aZkFlJm1vbcrQwTlrUFCHVKiK5MBNjW7xHNJB8W2VIDiUUoC5tmnd86NA
 n8gqPU823hzOyt5hS5fzJooi6lsiLVc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ELQC_kcMN4S60zVyaeyU6w-1; Fri, 22 Aug 2025 03:45:13 -0400
X-MC-Unique: ELQC_kcMN4S60zVyaeyU6w-1
X-Mimecast-MFC-AGG-ID: ELQC_kcMN4S60zVyaeyU6w_1755848713
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70d93f579ceso21776936d6.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 00:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755848713; x=1756453513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOvxBdRk8WyLBY2AJPQXTToCw81ShQ+fO0Sw+/AFfP4=;
 b=W3asDk78WtCNir480QiU4oM1V0w/dzAz6s/YfH9X5hTRDgzS7kUnfEXkGndJJ5Zmq1
 n3I4Qs4KD3gLXWxGqtrPY8bHVaJSDq0oa/fxwnZAjEe2bCyncDVcs2Y7WluJ5PDsD4/U
 qN2NxYW/4DEitmmWL4UETutS6Y1gBCyl5r2tXmg5L1snk/USZyoU6BbF561SZ5rStcDx
 queOqGg7C4sF/ng2Z4/d3WqkDs8DlDDg+TENaoNKMsa77OBoQTAlsJ6xSSYDdOH70itU
 sD591yqgaCG7J39lK1zvhircS/Bi4h5E2dATTg7aBTHM9Ftxi8CTO2D/79TV8Uiy0ER8
 ck9g==
X-Gm-Message-State: AOJu0YybQo175hzBskbkWqQq0oDJMbtH/nBFsGLuEjlPdP0aszefAp4t
 GzMpj5XxlRT46vUam0GmSVNTx0ExiGx6ffCEvoRFGUdolH0lZZ/mJp5ZoIQVvN90jrpkP8+fMOr
 mmjhC/QyBTqG5LauJX8mhSqF8Ni+wfX+Kr5c0IUz++VLLIer9YtlCqS7n
X-Gm-Gg: ASbGncvPVtWS+47TZJhPpGes/Nxdzvl/xDcOoMJPBxcH8WOc6o/GIcNaogHXVwoVA2E
 5CNyJPQ5HGAu8b1dvAk9WsAqzn2LjFm9D17C4M5vhoNRT9HOeivu3v9KQULjrK8Ql++Y6TQZNbw
 JbrZff/b6mM9SIABMDDABqdTb9G7GyH6RMvBtUI8UC9RhYP2W5tB9RXGxJg9ZQlkYxzuRTmDP9a
 BjhKT2wNTOeBz/D8/LU31Le3Dwd6vSo5vsn0x5wI0+L/k1GNeAU2TovnWfMg0hFl97GL2A9pLj8
 DdvegOYsDYu+m4XXjz3eUlvjwbGLoTZiTupoSZa2ESA9HKMZyY0i0fOJcTrLvABMAsBUVztHIUn
 Zca43f23QAk8=
X-Received: by 2002:a05:6214:27c2:b0:707:5135:5089 with SMTP id
 6a1803df08f44-70d971f6a0cmr25349116d6.1.1755848712924; 
 Fri, 22 Aug 2025 00:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4BiQE8TSlIL9ol3B8bcxpeTY7qEf+9s58NV2CMVb2jNamdpLAk3Ujx7EJGt2jxiwVghMDw==
X-Received: by 2002:a05:6214:27c2:b0:707:5135:5089 with SMTP id
 6a1803df08f44-70d971f6a0cmr25348856d6.1.1755848712253; 
 Fri, 22 Aug 2025 00:45:12 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70bc70c95ebsm71173546d6.67.2025.08.22.00.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 00:45:11 -0700 (PDT)
Message-ID: <5fa21509-c6dc-4e56-8e8f-a577ba2e34bf@redhat.com>
Date: Fri, 22 Aug 2025 09:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Lei Yang <leiyang@redhat.com>
References: <cover.1755080613.git.pabeni@redhat.com>
 <CAPpAL=zUs6WFYNPnV=L-W_BKYO0fpujfhHPG7c+UfW4foMR9Og@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAPpAL=zUs6WFYNPnV=L-W_BKYO0fpujfhHPG7c+UfW4foMR9Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jason,

On Wed, Aug 13, 2025 at 6:30 PM Paolo Abeni <pabeni@redhat.com> wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
>
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, and the kernel side of the implementation has been merged
> into the net-next tree; this series updates the virtio implementation to
> support such a feature.
>
> Currently the qemu virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 4-12) actually deals with
> extending the features space.
>
> The extended features are carried by fixed size uint64_t arrays,
> bringing the current maximum features number to 128.
>
> The patches use some syntactic sugar to try to minimize the otherwise
> very large code churn. Specifically the extended features are boundled
> in an union with 'legacy' features definition, allowing no changes in
> the virtio devices not needing the extended features set.
>
> The actual offload implementation is in patches 13 and 14 and boils down
> to propagating the new offload to the tun devices and the vhost backend.
>
> Patch 1 is a small pre-req refactor that ideally could enter the
> tree separately; it's presented here in the same series to help
> reviewers more easily getting the full picture, patch 2 updates to
> linux headers update script to deal with annotations recently introduce
> in the kernel and patch 3 is a needed linux headers update.
>
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> vs snapshots creation and restore and vs migration.
>
> The new features are disabled by default to avoid compatibilty issues.
> They could be enabled after that hw_compat_10_1 will be added, together
> with the related compatiblity entries.
>
> Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com

I'm wondering you could have a look at this series and its pre-req:

https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg02004.html

Thanks,

Paolo



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2518AFD8FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdAV-0003kU-IL; Thu, 26 Feb 2026 10:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdAR-0003kA-Te
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:20:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvdAQ-0004EO-DH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772119240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32R4yKlmMaA73jp+HIjTjcGytm+K5DPJT4euFAT5UqY=;
 b=iQkTUr/z1OGR1spsUgSqiGc+BKKbXsLHh9HyShUSnvmlrLjELmNTVQDnElMNPS/PMWoaYv
 wriB8fL+Uw+m1IrNSn5nGdHgcB/byu6daXd7yqm9xnxPI7wXuff88VzorG2cBz2cwY7P40
 cOkSP3pkXatBDsTO8uAMkwgmsJTnHEQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-NLwqXqN2N--2dhJCBXEUng-1; Thu, 26 Feb 2026 10:20:39 -0500
X-MC-Unique: NLwqXqN2N--2dhJCBXEUng-1
X-Mimecast-MFC-AGG-ID: NLwqXqN2N--2dhJCBXEUng_1772119239
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-896fb2fb9d5so100258096d6.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772119239; x=1772724039; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=32R4yKlmMaA73jp+HIjTjcGytm+K5DPJT4euFAT5UqY=;
 b=NLpD77KOMofrA+MfRW7cLqCd7HrsOuUs41fg/A9GOqaTiJoIndAOJYfGJ8/XFWQHz7
 +NL9cBrfuWvlRRX//5zbQwOObImQApiiWt0kue3eFJOVytau57R2/WKkDAlokv1bkDei
 R9gE31DphRkGTVLfmcj4NEyXTPNxQYN0kwXnqlRWOi+fUTlXV0J0vazMOdpbe14Km0Je
 kABDmmxeywvGUzYyEgI/IbVSWGjuj+TDHjqI6Q5u9gglCYFR5lTtlsCJ6Ssr4Spv9eWf
 +p8piL3Y0SbZUh9AIU//rTDE2tTo57kJIqjs45wWKC4XykK3va0WXOTzZjnRol2+3giL
 N/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772119239; x=1772724039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32R4yKlmMaA73jp+HIjTjcGytm+K5DPJT4euFAT5UqY=;
 b=c323HAoSUYF09FXMQu4h4pLFozSZrbhzwVUib7lVGxGN7GL7cGriXkK3kvo21jL/a+
 Ki50UbI/qyh9X+7bWwlvgfAfKtcMB2B46FqVa7KuFQ5thRIFHGTfPG2tnfuFeq6vltOn
 eF8NrZI0euA6NfAFIXNvUdMUtzZHcfxamzWv18uDQvtZjxkhWahcHE5H1AGO5bdSJm1z
 3QsKFiHQ5RbaUUvSRD27tD39D7TYw1ITwHgATAuNIfal+/qLD79uEOwxxHHQhvrDqAnD
 i3bX3SO80Y+oT9mKJG7s3kiDmdZ1rH3jLV6dqyPpnx0RI3sE7YO23/IanhWt+nKUEhsL
 GkTw==
X-Gm-Message-State: AOJu0YzRlcN5NGaPvlx5S9P6b1TFT/zMF8JTw/0T0/y3SrnQwiV9ydd/
 EuApb8V1XlwDkM1uVlM5yP2BKcg7kFvCzKS9F/FHNcqw+y7TErwY8xc+5M+XrCaqn37qh8pokxa
 f1LQ3wxGS+iFn6p7upFLVCh6eBqrB9A9S9TSHWfuo8pvImyUoMCKGvjLL
X-Gm-Gg: ATEYQzx3zqdNc+n6LHY0Us33bpLroAMWWJMzICBcFTvSpbV38hE50u0ku7GI1+Pjzr8
 8KT8UZzrgNnoxYj8E3jRPOUs4zq8i6984KyoEY3NlxxGuOAVOSR9K+4geb9aOR+HSVIk/vvI3O9
 EKqva8XwTs8GbchgARhH39bnIWhpHKy9wua4hBEWulLdyAjYZkSX0wv9X0K/z3RjB78dtpDrpsU
 QdxRT/vcjCAnO4j1eTG9cD2s1pUDmA4xGcQYAf0mk4yjA8B8VS8jajoVX5q5oWaTxnhV3UjZvi9
 ZFcejYSjKuJrDpsw4iZSbD8OXqitGNF/Rr80G1A8LrVB1xSn1PNGGa8yL9ghFFbxeX0O+bAf4yu
 jC/5T9KQM8f7lWAM7rl4gsczMo7Hm67zl5VXzPNDWAE7qZHi2jBK+FiYHruyJEJcZixx6ffF6sK
 /sT1ZT9g==
X-Received: by 2002:a05:6214:509b:b0:899:b3d4:e54c with SMTP id
 6a1803df08f44-899c7ec8d43mr35014306d6.21.1772119238715; 
 Thu, 26 Feb 2026 07:20:38 -0800 (PST)
X-Received: by 2002:a05:6214:509b:b0:899:b3d4:e54c with SMTP id
 6a1803df08f44-899c7ec8d43mr35013766d6.21.1772119238183; 
 Thu, 26 Feb 2026 07:20:38 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899c7374dd7sm20454326d6.32.2026.02.26.07.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:20:37 -0800 (PST)
Date: Thu, 26 Feb 2026 10:20:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
Message-ID: <aaBkwvYFNKqGjrrX@x1.local>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
 <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
 <aZ3OQLHuYy0zEK76@x1.local>
 <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
 <aZ8wGsxhkD76LRBD@x1.local>
 <ee35b828-c8e9-4850-be64-72d0842b2dde@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee35b828-c8e9-4850-be64-72d0842b2dde@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 12:47:55PM +0500, Alexandr Moshkov wrote:
> Yes, looks like it happens because migration stream for "virtio-blk" looks
> like this:
> 
> [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
> 
> "virtio-blk" contains "virtio" field, so migration stream is:
> 
> [virtio-blk header] [virtio header] [virtio fields] [virtio subsections]
> [virtio-blk subsections]
> 
> And when we load the subsections of the "virtio" device,
> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if this
> is his subsection. This is where we encounter an error.
> 
> Thus, the error occurs due to the fact that vmsd does not know how many
> subsections it has when loading (this does not appear anywhere in the
> migration stream), so it tries to load all the appropriate ones by names.

OK I see, thanks for the details.

I think I missed one important thing, that we don't treat
trace_vmstate_subsection_load_bad("(prefix)") as errors.. instead we
fallback to the upper layer by returning zero.

Could you put most of above reply into the commit message?  I think it may
help people understand the commit.

We could also add one comment right above the extra "/" check in code, to
make sure nobody will accidentally remove it.

Thanks,

-- 
Peter Xu



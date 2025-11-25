Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B086D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvBI-00042c-AB; Tue, 25 Nov 2025 10:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvB0-0003xi-4Z
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNvAx-00089k-T3
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764085312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VDVfSUn3lK5BAZkZgXDaQShq+gK9HdKWjS/q37sK6pc=;
 b=DsQWz5A8XpwGGeVnJ28rulm2s64ouiBtounC2WYcsND1e/MtOhJspVpPOuDpXuOB89GFiE
 XkjU2kFebCJhRNh/e5ymZYt1ERWPSXymTf2TxoxNNGYc22eDJ56QWJyk1FfOgeblQFhSSB
 DxR/IDqxssK/np0uuZgxCR++EYTSLqs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-FbFCKypdOLaTWmuw6zolgw-1; Tue, 25 Nov 2025 10:41:51 -0500
X-MC-Unique: FbFCKypdOLaTWmuw6zolgw-1
X-Mimecast-MFC-AGG-ID: FbFCKypdOLaTWmuw6zolgw_1764085310
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2e41884a0so1511845285a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764085310; x=1764690110; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VDVfSUn3lK5BAZkZgXDaQShq+gK9HdKWjS/q37sK6pc=;
 b=jVHrhJrPMDQwKM9X5BaS5YKkUTchql8Qh+FhK95FKV/d7bKUAagFcM/g14+pmSXcoM
 5MI2npJWbQuY+hTeIwSAczYJQuFIzPTEDa7V4COeVE0kNZxOVkAhZMVdS9Puhc9U+Trf
 4ee5U2HGdcj2eYTpYP/gOkf/ncKDkcbFbG48MkMsgeGB9FU+/mHGTLakfZIZDG5NfvYN
 blCcHP9f1fNuKcJNf8YDwM9chvC1dWjYLmk2XNt81BPS8aieqPuURtUFXbIzfzfvt9Gz
 mZlh0yxgX0Cp/iqrgxkn96pn2i1Hiyj3zH+30jN2WQ6c2wnjzB9IZRpz9jjuil1MTZGL
 7MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764085310; x=1764690110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDVfSUn3lK5BAZkZgXDaQShq+gK9HdKWjS/q37sK6pc=;
 b=XPwY9Np/N9uJnivb4mdkuxA4Szj8F0SfLkyS8hhZz8/kXGUlS8x37+wixL1sV4u+jA
 1RotuRPCwcKHNqcF2OvYE14VKdpN7oG+DJED1fgACGgcc4yILGAUZnOQbjJfbtsDAg3W
 +t4K4UNHaJG2XQ7b7VDOVQpIKSoL4kMxbcSs8rYyOu+V64tk2eyg3syDqYlv9a0bSpcU
 9/hTuuaizYmWVwxocS2aW4ojffYIxY995hnTZmDuISOiLM5dv0rYzn52jIv59vcDwaFs
 58hXRiISzeb1D9/rf5Vv9wdKARtPvK6U45cAgiM4YqDeff7EXwc4Ufx+EUIltLT7D8yl
 8VbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuDthQkxF4M85Oufjb/HTJrHgorXMbGlLnbQCXk6poanwsKvy3YWodkJx5ZYfW/83L3pV30qenmtLM@nongnu.org
X-Gm-Message-State: AOJu0Yz49m/prHOgtrWBI2ReoDkzpmUBHVMUM0IGz2f7xON3kskuoYfT
 5YVbRNUPcasPP6MvZPV94SmilILaB6mhJFCb7ub8XjvxT3Eqp9wvbBvgXjYo0Mf/tvexn8DeTJQ
 7kXhzjeGD9X1onvyFbUEy1fm9o8T6FNaAshisRq05YTpsxcvQrfAIRRCV
X-Gm-Gg: ASbGnctdMI5mFx45m00bvf35yZzJmuI5vJTshmVefvj4bonqfTeEodQk4f0ofFeHiEm
 I82XGqpKd2FspoCVYrgFZSnVHvu+PAjvbZt1av/hvnVtMi+kOXW/daHv09A+jDZ5jYQDww7ojvU
 i3bVO8NC4I6Ez8NS+DdwBq1DN7+T+gVAqz+N5gUCjPU5Dw1bqQOO4pnri/lzr6OirsNcfc5Ua5q
 5Umcz4EHV8sJfnnHDNCvfnSi+heXDPoxDNNl/lhL/20nHm4beoXcKfs9A4d2N/+552mSD5wDzSK
 oN/fwwwvBALmq6fA7BRM4b8bIOjKS6ppyEJqnH6feHRFS+JBOQi/7lx9cLly2SmlB/Q50l6Llbl
 zojE=
X-Received: by 2002:a05:620a:4613:b0:809:eb12:1ea0 with SMTP id
 af79cd13be357-8b33d4c71f8mr1922448185a.81.1764085310510; 
 Tue, 25 Nov 2025 07:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmtlfG0twGcJ1zHqoozayKPZ/kilzUhJ3qLZ3KEwpWbQYS58Xvj0tdNK3sLbYK1OdnO1M+xQ==
X-Received: by 2002:a05:620a:4613:b0:809:eb12:1ea0 with SMTP id
 af79cd13be357-8b33d4c71f8mr1922444085a.81.1764085310077; 
 Tue, 25 Nov 2025 07:41:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295db8b1sm1205995885a.40.2025.11.25.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:41:49 -0800 (PST)
Date: Tue, 25 Nov 2025 10:41:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH] migration: Fix double-free on error path
Message-ID: <aSXOPGbIj1MmgEAK@x1.local>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <87a50ak2mx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a50ak2mx.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 25, 2025 at 08:11:34AM +0100, Markus Armbruster wrote:
> I can include this in a PR I indend to send later today, but do feel
> free to commit it directly.

Works on my side:

Acked-by: Peter Xu <peterx@redhat.com>

Note: I think it's Richard's turn to collect pulls for 10.2.

Thanks,

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1612FF6E9A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ds0-0000HH-NY; Tue, 17 Mar 2026 19:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2dry-0000GT-Ig
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2drx-0005dN-5e
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 19:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773790236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDZMmGTMuWSL38nnk/Wm4TCQ0sPIDlEZfhFCndVAmy4=;
 b=YgjX2bZq4TyktA4ywDB8nxshcJfMXYuLKdx/8U03J8MxlRC5RzXCUQMttTw7xptr4QDpJ9
 9S+ll0Aea6byuimugqEZsujkxBfg0FoP9kPnPjpgQGyWFiwSUeG0RV3ZMh5E8A90RX4zHN
 YLRcZHX7PzRb8rFkBeyxHKadxNuCHd0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-ItCfeOSzPnC6_HNSTSrjgQ-1; Tue, 17 Mar 2026 19:30:34 -0400
X-MC-Unique: ItCfeOSzPnC6_HNSTSrjgQ-1
X-Mimecast-MFC-AGG-ID: ItCfeOSzPnC6_HNSTSrjgQ_1773790234
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509177a915aso19556521cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773790234; x=1774395034; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nDZMmGTMuWSL38nnk/Wm4TCQ0sPIDlEZfhFCndVAmy4=;
 b=AnvxEnG3ze37/iMKg+VIHKJTy1o33xMubLOzOV5qkYNFlt9ObhfV+QucbostSrgjLP
 k7eeGQMAvZgDln8kGdWKgpA1FowAGvSj+5Sq1hBIameDHecP4ek9q79nS+o6sYQ3FUi+
 LH2U6l1Mo3HrKblXT+rWJkJlh0F2hJNb5ejlO/G4cVhjr64fc8AlOkVk+Bt4ahgfFuEB
 Nwedt8tt9I8sw1tN4pGZHYg++QBMRFtBuK4ke7AywQvEQhhURHLpBdjI/CD2avQ4bubM
 p8/qH09SO5ftji1kZRNdkjUluRL/Li75Zz9P8CO8IOtLEtC2ReCEmyX5VChTDn3r4y9B
 8m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773790234; x=1774395034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nDZMmGTMuWSL38nnk/Wm4TCQ0sPIDlEZfhFCndVAmy4=;
 b=Qc6ULlSj6/bQ+agtLjhMd5I7IP45cgBDaPftaMckZdmA6bwHPmsP9AFDonR3kOJxnt
 6J+QapgMBqz3P+FDfrUnOj2q2y/G8yUJA5VSGiUOdm8S7BlMX9GOA6vLvk4rmSmDAZZW
 /mKSFcoPS4kwF8SDnOfiGc42jv/lO0pE19eJ7c84oTbL+cwXXh8Du0gMjFVVau/1+Fsb
 tDkkNlsgTjgqoIYwlV9rWMNqxkuRHU98kt8gbQ9kE+XuaWNZmjlIN0+Dv3pckIxSWAuY
 p0ibmFTzWnsHfnzKie4e+CaxBrVOl/bqzTwllz1xhUO/pCrVpQXGNYfGkw00I7JZsw/u
 eavg==
X-Gm-Message-State: AOJu0YyQPxQhAEJf7+cRphxb+n/wQgQ6Re6JiYQeFTshl/qnjdFIJPAE
 SygnAPtUaVYAJTjz9Bpe4HooN/huTg1oLCS9XiUQ2VBjRBBM3Hff2xzNTneYIZ0uNTguA4ZRQzM
 cMAq6oRBLRWZ3krI6TJpTsNJROoUS2sVg0+qn98k8VScSOP4FHkEilf10
X-Gm-Gg: ATEYQzwbyjV/qr489RQXtsPpW1MGnzpGQsmO6DiEknE9CdFSE+WUrIsDpYcxs9D5bFV
 MtfLItQl+PRnvZtrMKxqe/Ei1jksWfe/YbolkpcL7jQ5+IWISHHRV0QHtq/MhEta8eJ/gewldqm
 r8FDKVD1GPu4l7oKSpi3gwYQnaB/REeKmXsIjhIqjlYT1ftAmFxijTCz8TbpDztirKZFtvrDxlk
 mmMhQngDCsivB/9wHPidjPJq3oig/m6nmwRqWM+Ysr8YCAcDxtqkB9fCUEaaF3gaijyw8Avt3AM
 1OsnAuqwFJLQTWrTEpPeaRm/XKqY6VZU+pN5asvmuyNF+o2McKYxUvL8wBvzCK8cCuEvGbea/hf
 4tCJHJFEby3npPg==
X-Received: by 2002:ac8:5d46:0:b0:509:e46:84ea with SMTP id
 d75a77b69052e-5099811a072mr66299431cf.34.1773790234108; 
 Tue, 17 Mar 2026 16:30:34 -0700 (PDT)
X-Received: by 2002:ac8:5d46:0:b0:509:e46:84ea with SMTP id
 d75a77b69052e-5099811a072mr66298811cf.34.1773790233572; 
 Tue, 17 Mar 2026 16:30:33 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b135b7d17sm9187591cf.20.2026.03.17.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 16:30:32 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:30:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Message-ID: <abnkFu0BAHYpQqo_@x1.local>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-3-alexander@mihalicyn.com>
 <abnKKguESqlptJdp@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abnKKguESqlptJdp@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Tue, Mar 17, 2026 at 05:39:54PM -0400, Peter Xu wrote:
> I'll likely send something very soon just to show what I meant, it'll be
> good if you can have a look at that when it comes.

I've posted the series as RFC here:

https://lore.kernel.org/r/20260317232332.15209-1-peterx@redhat.com

-- 
Peter Xu



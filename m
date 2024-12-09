Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C1E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjhl-0002dq-Et; Mon, 09 Dec 2024 14:46:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKjhf-0002dS-QC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKjhb-0006AV-95
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733773553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rw8j8ZMTC76rmERXtaE3bnzwIzkYEIqwDpeVMfWNtzc=;
 b=ZH11x/f5L/Ag+RbqgZgnI2FDCSRlA72KMdfxm4BZigJAloK6gTEGpysnrxygptvQ2K8uJJ
 srb72A6WybdhIMXgMbDBcYpq9ET/QWsTowWZiB0owZjVOVBU9EHd0c3Nsb2xfRI9cVQri5
 RKE2owo0oVR38kyoffLhjv9Vrsa3j1k=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-S6G1f-ERO4SPLn1pnPkQ1Q-1; Mon, 09 Dec 2024 14:45:52 -0500
X-MC-Unique: S6G1f-ERO4SPLn1pnPkQ1Q-1
X-Mimecast-MFC-AGG-ID: S6G1f-ERO4SPLn1pnPkQ1Q
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-466cc5287ffso99417991cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 11:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733773551; x=1734378351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rw8j8ZMTC76rmERXtaE3bnzwIzkYEIqwDpeVMfWNtzc=;
 b=h7hQOZMuKv6i8iRyIy51/5bvGAiUSVpZeDNZgC4IszGvO+oGYc2zkbPJu0sbz+BBrI
 AA2eBK7+N7qET1scenBDwLDbCyznNZPy0EU5T3fw8Uj3wzaYUM6E6K2NM16O9wKqG9FB
 NNPN4IUxo0nxZyl3o/Bl4p8yxrVZakLsuOUasIsSWCnWA0rVv4VgFgU3LMIrfs7IVndh
 QjiWXSBzv0kB78SrkSblXmmeE/fCaPvIYArWATZgE2mawq9a82M9zMrTpCPnQbCwxQJR
 Vuss+qxGTBpqyOx3pfpWdwOrM5fqOHVO6+MzcyFkYEd77njQ9LLkYmi7/VuwuWPFWmwv
 inQw==
X-Gm-Message-State: AOJu0YxE4O07K3phXwGHJHxAkX7vF0RpTTfDMYFXo2RjoycbZoQxZ1e0
 AY981JW7WxbK6d/dMX//lYnVcnIWHN+bzAaxNG0VZ7Wgmn71lF0CDxz+Gmkkbd54OrJbaCCo74d
 kZkQ9hS+ffrPmejz7u79T0bN3jJF5QsiwUy83MzFN4Htj5OUwF7TS
X-Gm-Gg: ASbGncvIkIqnsJsh9p9lAsaK1NVfE74om0evZt6Z2Q/wlSHwQyrVIOUd9AUbD7iTL1a
 ZxXpjUkibRD/IBIMqVCRSbaeYZ9rk5IpoGlA3+8H+Ec6SoVJ3oLItCDE6fTJtdu8cxD8QoLG2aA
 b5uHtPLKvHgZwTl+bFsEeORHj4NQRmZWSWS81FI+vb6zpltpsExgH2G2eOiT5vqoFn9kntNBAFK
 mPUHQc2q+481wqBnZEaX18KDLT8hKyDDOZWapCMi0286KvBXdfb2p0LWV0X5OhpbgeNL+ab4rk3
 WyfVDCYoFV5IP6c=
X-Received: by 2002:a05:622a:4008:b0:467:5eb6:5153 with SMTP id
 d75a77b69052e-46771f31ecdmr35571651cf.19.1733773551602; 
 Mon, 09 Dec 2024 11:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdWraorpkD5iZMLYnbIDpiV2vg479clVaqqN9ZC903NHngEKhQTlhTsSZKkPhLb3k4EI0f5A==
X-Received: by 2002:a05:622a:4008:b0:467:5eb6:5153 with SMTP id
 d75a77b69052e-46771f31ecdmr35571151cf.19.1733773551284; 
 Mon, 09 Dec 2024 11:45:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467550b2a37sm24381481cf.38.2024.12.09.11.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:45:50 -0800 (PST)
Date: Mon, 9 Dec 2024 14:45:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 03/19] memory: add RAM_PRIVATE
Message-ID: <Z1dI7DJvX6Wn_jz4@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 02, 2024 at 05:19:55AM -0800, Steve Sistare wrote:
> Define the RAM_PRIVATE flag.
> 
> In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
> in a subsequent patch the implementation may still create a shared mapping
> if other conditions require it.  Callers who specifically want a private
> mapping, eg for objects specified by the user, must pass RAM_PRIVATE.
> 
> After RAMBlock creation, MAP_SHARED in the block's flags indicates whether
> the block is shared or private, and MAP_PRIVATE is omitted.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



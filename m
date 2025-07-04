Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50CEC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiuZ-0004Zz-6h; Fri, 04 Jul 2025 12:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiuX-0004Zk-Sa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uXiuU-00057v-Du
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751645108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwP8AxRIMdKc/BdGp+NHOKLkPuM5xjeEB+IJKXPWZvU=;
 b=QWYxzbvNVtwbRsyAZSp6ciqjdJKXt4Grjk4VPD+RudPxYqgdl0XwZYABeFsZIXPULlH1fx
 c+gMqhoORXCrr0fprMCc7O9gNa8qmEIetmFEFOdyhb0lqWjG46LZJGwZ9MEJGnu91WcQS4
 w7La7Mk7sYFgE4BE2SrW2WBZ7FZgIY8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-jR7Px4avMcW1UZ2mBcgyxA-1; Fri, 04 Jul 2025 12:05:06 -0400
X-MC-Unique: jR7Px4avMcW1UZ2mBcgyxA-1
X-Mimecast-MFC-AGG-ID: jR7Px4avMcW1UZ2mBcgyxA_1751645106
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6118b00040aso831011eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751645106; x=1752249906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwP8AxRIMdKc/BdGp+NHOKLkPuM5xjeEB+IJKXPWZvU=;
 b=DShEqAZhs20DNyu4KBSupEB2Xbx9I2o934JlD8OwIg0XsKEi0RXLaHdwALLb6wbHvZ
 3/4CR2gt+x9y7o5nVzgRbotGG+bWXSM4V1o7pw4gb9jjxVbFsvfGrWTf8dhx2Nf67Uq6
 hmHyQYMYqd9UXKmwT1/lhGWgBuLg8yH0hpPksi39czCG/rw2EdDZ4FpEuZ8p7qe4p5Y1
 QkVnLz8EOneNKWDTlvfejAOpRtYJW+ah1HvzYeWlk3CrXR8x9u4vSnNS8KUw4C2LZGz5
 C8iK6qZDHhdxAJ6uM4k9MjzxNT/yRQc5XnvUR+Zxj3jtcqo7A83/zpSoIiQaOe1/h3RP
 7d7Q==
X-Gm-Message-State: AOJu0Yy9RSi0z/E/arQlTcgy0iVCm8G/Tsu6CXVPl/RGBZaB6CaPoQ0e
 tVmtZw6RFvEbjgjPE2RvG5zii9UFDMlF+vZMDM0m8IchQkkCuHcJiPaAwpThk/EawoD9+qNKyrW
 5IZJLOqwrVTjyQs88tuAGfiJHC5tkqHFnJ88Kv7kckq+1IuFkwpUtCXRL
X-Gm-Gg: ASbGncsK7HhuV23g+8e7v/dzwfn/WoWi0BZ5JrT/IFFbXRtjkSaRpUXxiM9BWQv1TgB
 1nbT+Y3I97VQULMAj0PLlig8NZt67foDNBAf36Cnjl3nv+Lm2LCnn2vSR78RqHc3cmlb3a9NVNi
 bORwRFKwc7Opw5BspDeGLxsvfg22xOnZGrAK+3FMqkr8/SpyskVblH0ViLn3+DGMKQp62UV7N3l
 TAgEOgV9iFDBxndXoX63IPQP1bkC/nE6bys2mzPtR+Hx4FzvUTfrwPZCgeijw2vHHPWyb6rrkwb
 k+JL++wgh4K2dA==
X-Received: by 2002:a05:6820:2903:b0:611:f244:dfa5 with SMTP id
 006d021491bc7-6138ffa9905mr2617115eaf.2.1751645105777; 
 Fri, 04 Jul 2025 09:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoqluflMRXamDCHRwB2qzxD3h24z1yiKpi+Z2QTL7zGFT9FN2rQplZZdiiIDLiA4ZC7KYaGQ==
X-Received: by 2002:a05:6820:2903:b0:611:f244:dfa5 with SMTP id
 006d021491bc7-6138ffa9905mr2616974eaf.2.1751645103146; 
 Fri, 04 Jul 2025 09:05:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e590d63sm350085eaf.26.2025.07.04.09.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:05:02 -0700 (PDT)
Date: Fri, 4 Jul 2025 12:04:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 09/24] migration: Do away with usage of
 QERR_INVALID_PARAMETER_VALUE
Message-ID: <aGf7qC9mMHkVkbMX@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jun 30, 2025 at 04:58:58PM -0300, Fabiano Rosas wrote:
> The QERR_INVALID_PARAMETER_VALUE macro is documented as not to be used
> in new code. Remove the usage from migration/options.c.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



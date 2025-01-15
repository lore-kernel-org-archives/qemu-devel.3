Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B0C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7S0-0000c1-89; Wed, 15 Jan 2025 12:45:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY7Ry-0000XD-LU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:45:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tY7Rw-0002mF-CX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736963101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88D3l9AX5z0QxwWHeY/fCGjEu0RqfRtj9gKf5QH+zM0=;
 b=fS/nJQDNcVfujYXGUbgOKRqGkxiL8yOA5MIpc/xje6/49gwNnTiwKaNKpeVwdEpv81H6uj
 CVD1n8SebZVcJFAbtdbRVo4lSHzlIJLFqaTv7ST0Lx+5igj6lRINKgSMP7Uprd3Re9FFi1
 DQ/KLj4axmAbNYnzUa3kkaX834Sv6cY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-WmlzvObLMiSSIRNc9rJ9zg-1; Wed, 15 Jan 2025 12:44:59 -0500
X-MC-Unique: WmlzvObLMiSSIRNc9rJ9zg-1
X-Mimecast-MFC-AGG-ID: WmlzvObLMiSSIRNc9rJ9zg
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so148051a91.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736963098; x=1737567898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88D3l9AX5z0QxwWHeY/fCGjEu0RqfRtj9gKf5QH+zM0=;
 b=dHqDCP0e8iMY1eWDpue517N8aXELPQsE6n+CFu8AUTzS7rylK2ltnsJgvkGGrYWV+E
 ERRF8Db0+3zjAKiI2pKnb7pgbrF/YAouNclp5XuYg6ltZTD6Stb4UqiEMlEJ2v8RvWTW
 RiRGIwT/nLQHLN8KSBkTI/xrn9fACpl0Esxr4zquX3T9lW91Eq4n4ZVx2VUbZZJFdlzy
 KBNxlNTeIKCfaqOEAe/9OB9z5yoiTE7A0aqFnjk3f13ZoZ7i+6GIqsXW99/ESbm55YfU
 qsj6AZuGn9GTXuwHyfCeLBEpBzJMaie62a0BBTaNM1mPKh3RUsOr2fx/mei9MS5VAl/X
 kS3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcimaRS4uP7UkiXJEC6Nj8/3lYsscNU19bMAT3PbHv8Ru28+mO7zQpJN+8PeA9WhVic40CjsAK6pWi@nongnu.org
X-Gm-Message-State: AOJu0YySi0JrNWQrPRRmsK7IIokqRcZF65nx6i8JDkU4xGv5GlJaRqpr
 RWk20so3bmed2y+xSThh8C2UhtEIXnMUQtqOsp3K0JkS8S0a9y4ZiGeIphyQuchvc4NYDbKDMWU
 n2+s95KVQLW9eDkulCZIlWiveUak2xVdnjcQ7+WkDs+ajgBerjnljjZP2wvAW
X-Gm-Gg: ASbGnctSe7vM5mC4hCtJ8oHdJylHXb3iM8EEaijvoNshkuwUenT85q8tFQv3LgIKALb
 3sGmfR/8XCfoCGIdGBlYUzf3J5QsgX6jL6dlYubMH25e3S2dyAZ2ll9bdyqRM7gtHjIX5jMWvaP
 mxujPJh5RoG43JnxUtXRT1T5x10idoPTkSQX2bFIVimiHFERSSiGrwqfcL5IyL+s6ihVwa4swQs
 uzs2sPyozgXGUSRvYYHNYwRSIm7DvhxSO0bsb+yR7l4HhU1d5OWxA75TSPfMG4ta1kvrZya8/6F
 HbNTxYgW6S+JE34/lQ==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f548e98373mr42081202a91.8.1736963098438; 
 Wed, 15 Jan 2025 09:44:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx2uxmp+UN2CVcx3CpZzhORCqGoVaRTnXi3SnAvVw8URB0/m46XtQRJL0EeT4/TkgqK6+upg==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f548e98373mr42081155a91.8.1736963098055; 
 Wed, 15 Jan 2025 09:44:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c33172dsm1650544a91.47.2025.01.15.09.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 09:44:57 -0800 (PST)
Date: Wed, 15 Jan 2025 12:44:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 04/49] hw: Add QOM parentship relation with CPUs
Message-ID: <Z4f0FmfT-FnwN8yI@x1n>
References: <20250112221726.30206-1-philmd@linaro.org>
 <20250112221726.30206-5-philmd@linaro.org>
 <20250113132832.049f651a@imammedo.users.ipa.redhat.com>
 <6f9225ad-edc6-4fe0-b0e6-8a93e7f50102@linaro.org>
 <20250114111829.2f577596@imammedo.users.ipa.redhat.com>
 <87zfjtfu3g.fsf@pond.sub.org>
 <20250115111928.17950323@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115111928.17950323@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 15, 2025 at 11:19:28AM +0100, Igor Mammedov wrote:
> Another question is if it's safe to move/rename device withing QOM tree
> wrt migration (i.e. when 1st instance has old QOM tree and 2nd a modified one)
> 
> quick smoke test works (migrating from old qemu to a new one with this patch)
> But it's better to ask to be safe.

I had a quick look, taking the simplest qemu64 cpu, I see two vmsds: "cpu"
+ "cpu_common", provided with different "instance_id" for each.  That's the
ABI for the migration stream so far to match devices on two sides.

From that POV it's okay to move CPU devices within the qom-tree, hence not
yet part of the ABI.  It matches with above tests that it would pass.

Though I'm not 100% sure this is wise either from migration POV.. because I
think we need to rely on strictly below on both sides of QEMU src/dst:

  - Exactly the same QEMU cmdlines to be used (e.g. -smp X should be the
    same on src/dst, or anything that creates the CPUs in cmdlines)

  - Exactly the same QMP command to do device_add / device_del on CPUs,
    with exactly the same parameters.

I suppose only above be guaranteed by the user (or, libvirt), could the
instance_id to be assigned be identical on both src/dst.  But I'm not 100%
sure Libvirt can guarantee that.  E.g., we have vhost-user bug that can see
different instance_id of some slirp instances after some plug/unplugs:

https://issues.redhat.com/browse/RHEL-56331

That might be slightly different topic, though, so the movement in the qom
tree so far looks ok..

-- 
Peter Xu



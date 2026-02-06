Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D16FEE20B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voOZu-0007fI-Bv; Fri, 06 Feb 2026 11:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voOZr-0007ey-UC
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1voOZo-0007M7-FR
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770394857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9FhSHYXnLFHsUJRGV2klsaMP4YegyMHfyhG8cxCLqY=;
 b=PB/Df7NaLfdm/6YVL/8uFKh67cQXM4ZZI0d4UrNlRveYvSQa1B01ljfEtWm+sO7olUBPbO
 JnGYtf0IHPPBNmyOtxh2KcZwoZScDIGTgVctLM8Q3IiUi4Smh/Otw5iASdNLn1ww/aZnLX
 Fl8PMNONsixOcJ0dzJ9t9tK+qNIGwJw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_lUoQ3B8PPamGtK53WhCtA-1; Fri, 06 Feb 2026 11:20:56 -0500
X-MC-Unique: _lUoQ3B8PPamGtK53WhCtA-1
X-Mimecast-MFC-AGG-ID: _lUoQ3B8PPamGtK53WhCtA_1770394855
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8823f4666abso23453996d6.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 08:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770394855; x=1770999655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s9FhSHYXnLFHsUJRGV2klsaMP4YegyMHfyhG8cxCLqY=;
 b=kJ3rP4gHy3Gc7MJ5Mp7vD/gKxz+AXAbt7jnqRQNlVOQc2h2ABW9Cn5aGaRUk/dcc+U
 FMV0c6OPxTw9/AVhhWQPLmcgGtxeIUI+Z69G/8EmuBTCiAn0e8n2y7oLhqiH17CaQvJt
 FikXB/rILXqIPbhkGGD5/p9BX6AL5+67v6Qy7s2YccrDr9HkUadPfl1xfAckVe0mpP4l
 mAO4CwrQCfX0aw9bIZgRyABDr2wPLecKNfaRMpAsb6bKk7ENH2xBK9QD+KcB4HLX3VL1
 akFaBGJSUPmxx96EKyk9yLQ+S+XZ4HN3MZnlkqsb8DxkMykzb8xa6qlnQHPCEP97EPQo
 rxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770394855; x=1770999655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9FhSHYXnLFHsUJRGV2klsaMP4YegyMHfyhG8cxCLqY=;
 b=UdfZpKkB0tGNYR8gy3WQ29qxyCz1pia3znMu8v76gFQiTYzeXN57EnZG0TN9m6SGaC
 3EpDHwXI11ofQcQA+WMMEgdEexaC7WskpQEUQbjCLidIqtItyoI0Q4aPd8/XMuBqGUMo
 arqkpuChhaOdvK7C4toaKDbUe1OxgoWwraVmNimSkzeXCXZyZtDdzDX8lUoXwEo1xquy
 BAovtdwhWNs/FFyC/L/gRrXjXrQOAkNxs/UgqHbeTVkKZ6Kx1TbE0QkptaIim1SviRE2
 e1c3pN74n0NxLLDMhH2b14ll+5hypVHCwIjC32wESAaKIlEemw3Rcu2rB+gX3ixFDxIE
 KIDQ==
X-Gm-Message-State: AOJu0YxjyB5seD1PxoPB9uX5HIMA7CwxC6cY2l/ERaCtYPFJaKbKPkA4
 IXH2ZiNvUIhl1pAHr8BPpqKn3ujKpbRcXy1k8BdYwM5TsXedYAT+g1Fy0gdyXIdKUN9LuhjrS8M
 gxKcfwYkBnLKYQrCiAyOhPvkjaiyv0WjahDjkhRtc5xEqHz5C/XQpisi+
X-Gm-Gg: AZuq6aI0B1O5qElTqWnqy9bJvpq4ln2bTW8V3o96SWsxmzUaIN6D65+bM4FF6doaPqI
 fvP+5yycqeWifaI08uReAurXx7VCT8elC4lzcH1k61IJTjVmVFjywOxXSCEI34WtltMWTRpaNMq
 8cXRg39eJ4ejuiV0h2FfxIGPA5xMafC9KoZWWaKmTiFdVKYwHIA4K9yl7QYK/1dtiO4bIYeed/s
 Dlbp3/j5j4lsviceVfcmI95TYysrj7P4DIIEzyGTZaXtVRXv8jYDsRtgMmhw+eyUMBCXaBkzh/c
 Ufky0tklXc9etxbCN1XUjDxrBuk17LAHn27fZq3DsUnkutl1hgtti3bb1YlUPXubtP+UFHEp+gc
 //Dk=
X-Received: by 2002:a05:6214:3016:b0:894:81ba:50bc with SMTP id
 6a1803df08f44-8953c80e12dmr48343986d6.30.1770394855409; 
 Fri, 06 Feb 2026 08:20:55 -0800 (PST)
X-Received: by 2002:a05:6214:3016:b0:894:81ba:50bc with SMTP id
 6a1803df08f44-8953c80e12dmr48343346d6.30.1770394854795; 
 Fri, 06 Feb 2026 08:20:54 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3c740sm20723876d6.11.2026.02.06.08.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 08:20:54 -0800 (PST)
Date: Fri, 6 Feb 2026 11:20:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 8/9] migration/options: Stop freeing s->parameters
 members individually
Message-ID: <aYYU5fbU5l4grFav@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-9-farosas@suse.de>
 <aYUWwSxnsWn1Dfu0@x1.local> <87a4xmqcmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4xmqcmn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 06, 2026 at 09:29:04AM -0300, Fabiano Rosas wrote:
> There's some amount of rigidness caused by qdev requirements
> unfortunately.
> 
> I'm not sure if I ever posted it, but I wrote some code to move the
> parameters into a MigrationOptions object so we could make
> MigrationState not be a TYPE_DEVICE anymore. But then we'd end up with
> something like -global migration-options by default, so it kinda killed
> the idea.

It's not strictly about TYPE_DEVICE, but reusing of qdev properties, right?
At least the issue described by your comment was about offseting and it
sounds like so.

I just want to double check with you that I think the problem you described
will also present even after applying my other series:

https://lore.kernel.org/r/20251209162857.857593-1-peterx@redhat.com

That series only removes the TYPE_DEVICE dependency, but not qdev
properties.  I think it's the qdev property trick that is relevant at least
to the offset issue you mentioned so MigrationParameters cannot be
g_new()ed.

The major use case for this qdev reuse is: (1) help scripting, so as to use
-global migration.XXX=YYY, (2) support migration in machine compat
properties.  IIUC (1) isn't a major thing we ask for (again, maybe I used
the most of it.. but maybe only me; I'm not sure..), as long as anything
can keep (2) working then we can consider.

-- 
Peter Xu



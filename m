Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06409ECD9B1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7iz-0001xn-0G; Thu, 05 Feb 2026 17:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7iy-0001vb-85
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:21:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7iw-00036e-Ti
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770330077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsiIcvkjrtK5OTIyRKLSXlRE/xxsFUeGIdGzKWBzlOI=;
 b=JYQz4Gq0OkSJkjcKiu+xZw4Nx+6tDwGFgqLtXO2qjIPbq8SfAmzkNPoO7lS9WmD3/kOwtt
 P4QqDdiSJlMNoJhMUkLdpPAO6I3KJGZ6zQPTIOczAyezPrNUuIce4ngxyvVg6LSbEbdMJa
 K0q6X+pKczYOhpFgXQry1HUf4Z/SwrM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-JOzyy3XhNQGsRZzClmZGww-1; Thu, 05 Feb 2026 17:21:16 -0500
X-MC-Unique: JOzyy3XhNQGsRZzClmZGww-1
X-Mimecast-MFC-AGG-ID: JOzyy3XhNQGsRZzClmZGww_1770330075
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c52f07fbd0so17121785a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770330075; x=1770934875; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XsiIcvkjrtK5OTIyRKLSXlRE/xxsFUeGIdGzKWBzlOI=;
 b=W09w9eTBTK93suf6M3DoBneuEwk6ozgoNm2ygEZUxCjcvrDC29wBPki7xakmDjFIOs
 DXr9nXrU3UJhLY9lPrBv6ofmJCu+6JLRofh/lDQP81pu/ii/6C9hZ2+qQ2kNDMLLDtVe
 U8mFUussfH4TZkOv0YTdnL5qvZusnTLDCcjkFiMzdvZAFGtmgck00jAhwVJxSUR88URh
 SiN4E1eXS5AfwajdXawRsyx9BZBABPKZe63Mi8vwLve+qUa8uc1gYYP84m5pK0/9bp6q
 Eq12sQew+kKbXuhNZGnMUcxF9j5MIldZFpaEmhxqlXOaqzAAphclz5y2AGt7dmwpAsEj
 IoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770330075; x=1770934875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsiIcvkjrtK5OTIyRKLSXlRE/xxsFUeGIdGzKWBzlOI=;
 b=KrQUfiW+vvwhCptO82XuNdxoXUJy4/SkLvmZUq5WsbX+K8F3MwbhDERxYejStmT1ET
 kObS0aVORubs8QQojvwI0JOjq39SkRcFQhGxo4iz3r0/0jrZ6JEpUbVofmSkaV4HcTXu
 oJVAB/9UiyxEbmjR/h8NXJLp9SXzfDsWs3KG7oKKQfMUF3NkT5ZuUHYvgiYL0XmL3cFB
 5JT/vvjucbKVhjffVQHGmtaf3Ni+JdwiIKwsy/gDiFAV4OXpp5YcF0BtxG9lfAwVR0uV
 sWhm6sX4J8bZNvSXeOW0F4DJgpf6hqddUH3vkoErZyc4JG6fA3Nu9eOfmRM6lz91cmNE
 tmAA==
X-Gm-Message-State: AOJu0Ywi8AiBhmk+TNurAGkWoUkW8zRsqwMHVyuEyljsI18Y3x+HToZP
 pkMcR6Ga+UwvokJXWv27Fuzk0Mtp4Fzo9/9L7syuumxT+Wugon+EgVC3IA8Vf7wqmNy7yr+7I1u
 eAX+8uok2k7gWr9GwGTL5PDqP2RG+ftps+YbiiKdP9atwflUcx1tChL6/
X-Gm-Gg: AZuq6aIW1g2ArQ3fL5wrXKMz7KSGaYQXDyBkLXM8EoAZ9YodI6AemiO1g8kAQYbQ6nP
 3CzMLoU0gUyIjzYMKiMdobUvAHKxCLwBD7PsuWfPYqk8OH2oFVmMxEMR+vp+RONJs2PXZRovLVD
 SMtRX7G7D48kBRMPdXV0NFyR1r7hjbJpHsnvUYHooMJnHoaHRojnTApYV3j2Re7GMyILc7e2xlI
 Yh5+If3a+Gfx58duvu3buWESH6eE80IG7mVaN08JQTu0K730tTSV408LWATil7zKwfXN57UMvBr
 MAz8iB17OXonze+JVJgzHSGx9YymUvX6LXd+LnTyxZgK+XF7L3JKXxxe3O+Fy+R0RaX+3SBib9y
 Ojlg=
X-Received: by 2002:a05:620a:4612:b0:8c5:2ce6:dca with SMTP id
 af79cd13be357-8caeef2fcbamr96457285a.6.1770330075480; 
 Thu, 05 Feb 2026 14:21:15 -0800 (PST)
X-Received: by 2002:a05:620a:4612:b0:8c5:2ce6:dca with SMTP id
 af79cd13be357-8caeef2fcbamr96455185a.6.1770330075061; 
 Thu, 05 Feb 2026 14:21:15 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cafa4b6b8dsm26216885a.50.2026.02.05.14.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 14:21:14 -0800 (PST)
Date: Thu, 5 Feb 2026 17:21:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 9/9] migration: Use migrate_params_free during finalize
Message-ID: <aYUX2U7uc7jO72Ae@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-10-farosas@suse.de>
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

On Mon, Feb 02, 2026 at 07:41:01PM -0300, Fabiano Rosas wrote:
> Use the recently introduced migrate_params_free routine at
> migration_instance_finalize() so that newly added pointers are already
> freed by default.
> 
> Special case: The TLS options are currently the only pointers that
> also have a qdev property implementation, so they will be freed by
> qdev using the .release method. Update the method so that a second
> invocation of qapi_free_StrOrNull doesn't assert.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E568CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 09:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzCm0-000167-UO; Tue, 23 Apr 2024 05:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzCly-00015e-A5
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzClw-0003bQ-C0
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713865747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7TR0DYSlqpy3tXMA4xysJX+ccLoaqSBSZAeBe11VhzA=;
 b=iQi2yTDLjZYhEb9ZH3F0Y11Me2Fz2ypnU7Vgyr8evTX7NEdKqYesLtolQz6/fXJbgEUP4Z
 Oljq7AUKZ2tkrC50/Lu57HITiVaz0BFJNzRgXH6rTtB1X6a1A5ZS6L9IFl+K1LGsk/h8al
 jDGwrYk3pmvnXBQVRYgxAbQKPEd34iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Ecel4J5TM3uUrxTG37FnXw-1; Tue, 23 Apr 2024 05:49:05 -0400
X-MC-Unique: Ecel4J5TM3uUrxTG37FnXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3626C80591B;
 Tue, 23 Apr 2024 09:49:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D01492BC7;
 Tue, 23 Apr 2024 09:49:03 +0000 (UTC)
Date: Tue, 23 Apr 2024 10:49:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 02/22] target/arm: Add confidential guest support
Message-ID: <ZieEDDhjZYoBUUW4@redhat.com>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-4-jean-philippe@linaro.org>
 <ZiKa6MQaujEMlC23@redhat.com> <20240423094456.GA4454@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423094456.GA4454@myrica>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 23, 2024 at 10:44:56AM +0100, Jean-Philippe Brucker wrote:
> On Fri, Apr 19, 2024 at 05:25:12PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Apr 19, 2024 at 04:56:50PM +0100, Jean-Philippe Brucker wrote:
> > > Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> > > support the Arm Realm Management Extension (RME). It is instantiated by
> > > passing on the command-line:
> > > 
> > >   -M virt,confidential-guest-support=<id>
> > >   -object guest-rme,id=<id>[,options...]
> 
> Hm, the commit message is wrong, it should say "rme-guest".
> 
> > How about either "arm-rme" or merely 'rme' as the object name 
> 
> I don't feel strongly about the name, but picked this one to be consistent
> with existing confidential-guest-support objects: sev-guest, pef-guest,
> s390-pv-guest, and upcoming tdx-guest [1]

Lets stick with 'rme-guest' then.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



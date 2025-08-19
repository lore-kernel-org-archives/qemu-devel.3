Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84624CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoO1N-0007Dj-Tc; Tue, 19 Aug 2025 11:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoO1G-0007Cc-TU
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoO1E-0004jo-Pp
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755616351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MesJzu5FyrprBcReCE7MAVcGKl0PwQbrw+WGINHFwHw=;
 b=J4skY7OAg1I5AJJMwcK1viJrfdr89jSxV0qsbLf2E07QsOdqE/Q9nz0J8cBn0+M67XlaHb
 WQVjL7DlH9tH76Bchv9bDLAyzvSBC3k/0I18WQ/fICzHAzeRZXWE6FfN1VO3QUGQBsscRK
 SvqF9AobWiIt1+dXaTEXS+yic93SxDk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-rOw-BpY0NPGotOx1FLTdeA-1; Tue,
 19 Aug 2025 11:12:29 -0400
X-MC-Unique: rOw-BpY0NPGotOx1FLTdeA-1
X-Mimecast-MFC-AGG-ID: rOw-BpY0NPGotOx1FLTdeA_1755616345
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE10118003FD; Tue, 19 Aug 2025 15:12:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DD9519560B0; Tue, 19 Aug 2025 15:12:14 +0000 (UTC)
Date: Tue, 19 Aug 2025 16:12:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 15/18] whpx: arm64: implement -cpu host
Message-ID: <aKSUS2-JrMBX7JXo@redhat.com>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-16-mohamed@unpredictable.fr>
 <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
 <8e64fd77-9969-42b3-bbcd-1ed8de910ff9@linaro.org>
 <CAFEAcA9OXu3=HuA9n+Oo0C5K5hTG+kLr9xsM=geBJ_UtCi4_-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9OXu3=HuA9n+Oo0C5K5hTG+kLr9xsM=geBJ_UtCi4_-w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 19, 2025 at 04:06:45PM +0100, Peter Maydell wrote:
> On Tue, 19 Aug 2025 at 16:04, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 8/19/25 6:24 AM, Peter Maydell wrote:
> > > On Fri, 8 Aug 2025 at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> > > Can you follow the QEMU coding style, please (here and elsewhere)?
> > > Variables and function names should be all lower case,
> > > and variable declarations go at the start of a C code
> > > block, not in the middle of one.
> > >
> >
> > In some cases, including in this function, I feel that the rule to
> > declare variables at the start of a block is not really helpful, and is
> > more related to legacy C than a real point nowadays.
> > As well, it sometimes forces to reuse some variables between various sub
> > blocks, which definitely can create bugs.
> >
> > Anyway, I'm not discussing the existing QEMU coding style, but just
> > asking if for the current context, is it really a problem to declare
> > variable here?
> 
> The point of a coding style is to aim for consistency. QEMU
> is pretty terrible at being consistent, but we should try.
> The rule about variables at start of block is not because
> some compilers fail to compile it, but because we think
> it's overall more readable that way.

There are also potential[1] functional problems with not declaring
at the start of block, because if you have a "goto cleanup" which
jumps over the line of the declaration, the variable will have
undefined state when the 'cleanup:' block is running. This is
something which is very subtle and easily missed when reading the
code flow.

With regards,
Daniel

[1] I say "potential" because we unconditionally build with
    -ftrivial-auto-var-init=zero to mitigate this danger
    in practice.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



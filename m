Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9853DCD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVQoJ-0007gw-GF; Fri, 05 Jun 2026 05:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVQoG-0007go-HY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVQoE-00086i-9k
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 05:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780651543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pmixKMJz8Skuq0CM/RFSXzIcMMTim1Ty/abLCU7aCv4=;
 b=HI2ELuaDUyg2hlNLVx51OyNF+4UMkADmHM6JyJQ4Nge8yowtl0SPaz/D9dm7VTQ1eRHQ/Z
 A1ac5v/LD0YyVNBxpWK0i1JE6DVNxVZkj+SIqNCdyDoDpomUPr+dvSOuxJ4SJl8bzIbjaA
 POXiZqk9v8iMz3AesIQCLVDnbIaaiEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-FfiBnhKFN86dAQ2vUdpruw-1; Fri, 05 Jun 2026 05:25:41 -0400
X-MC-Unique: FfiBnhKFN86dAQ2vUdpruw-1
X-Mimecast-MFC-AGG-ID: FfiBnhKFN86dAQ2vUdpruw_1780651540
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef9437b7aso1181244f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780651540; x=1781256340; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pmixKMJz8Skuq0CM/RFSXzIcMMTim1Ty/abLCU7aCv4=;
 b=bMXdnmPOJbiNVOj+JT5oVvVzxw9jajAEZf4UH9LIfb5oAjnxHR9xE7NkaScGVbzJyy
 dl3EtPPc5eT8HhO4VjIx9IeWg2wFG4KxOnHChw7ShKWAMPdci2Kio3Atca+01+EKddjP
 UEIJNp6XkfTEjysmg+8igLfvmqhpnqlAKj7uXavDBwyIrZ2JqYbqXh8XNoXhAPe+EWc+
 M8xEnywOoGrFpO+CfnmopbtLaS8QnPCf0EQcyjFLsUVrN4C+LpjiReEbbBbMxx8kkNtJ
 IgMDeRLqMFgrwO6S4UUM1NwtAGAxT9GzkMMPk3fEL/ojAgO79JidXIk1L0S/QyB4P/k0
 crwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780651540; x=1781256340;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmixKMJz8Skuq0CM/RFSXzIcMMTim1Ty/abLCU7aCv4=;
 b=BBEBmmhY6ceGAafrwuI5qyrXYpnAldjVWN1xDfLLmk+dnSJG6eJuHuMVwyVxbgPEEp
 mCtFv4pnl+Yw9W3vXilgmAbH5xVJmCG/c+ZO7Z9v3Uc0kVp2Mb+Dkl5I63+32SP5XikB
 i6ii7JrazcrNiMlJ/xb/4eHB8xRysrsKW34sSCtM2SgS9pKZVanB8WBhhFvPMgzsXi7i
 K04anpENw80BMDH57DeeG+Rd6iXKVgxvEAuCDEZw3PxgIMqDPtQjiVcwWZmQIJ3lQygx
 ltyTqpjKDw3d6E/dWXObhou9EgMYM3HQ2G+uPYyL0eI9v6HO88V4FvxBuqffzK+q/zDk
 UuSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sMUIY/GBJDj2hzUugLmDS87aYiEOvTKhyt4D5aNIqBV5zpinqiEvn9S0AUDA3WpTdNpFd+Ghl0E8/@nongnu.org
X-Gm-Message-State: AOJu0YyvJror9ZvzHazfk+ZO3Sc8zqA/uufzVeMDWiAhotr6uJa1VQXf
 jNXAAau4VcghJYIoPPSVFNHm90aqcEn6ivRrA6/W+o6Dho0SeSIU9T6vnFB7T6rECv6ZZzvUBEM
 S9v3fZyBTNQvRmEItICaDjo5hzJW9RKfGIdzakf1gyjAX8wrx2u9jGu5z
X-Gm-Gg: Acq92OGJszM0n0n4XAoH79eT0Xa43ujr+aCXc1rhpMb+cs3ehVQ1uy8kpAXMTQwI3db
 sRlrQ6EXgEn2cHace3uxvCQMzhILaM5RrZEG3+BYUPa/q9G/VkBL9bOXj54EokqQXClzP8boZ2P
 BYMvkM9rLMURy0Gl5gD8PSkrwfUwv4h7EkHLBvdg0uscI/pbIvrk8deB8EbzUq8JRU4w6ZFQNTY
 z3l3pTtk9XdNBMjW8itA5z7BPbC/h8SRYT1QDoTWMrzkrfkVNMEwdufmxtIcVk8wZabYcbcs7FA
 WG3p4nTska0Sz6QtWANnCXAqA0lI1WBqsswe5p+H4NJdUF8l6Lym1JwGXiElkrI1s3wS/o+oS9C
 Ir6ctRY5zyKoiwelmCO693hQas1b+SXz0Jjb4EHDp55VnImLmXhiknLw=
X-Received: by 2002:adf:fcce:0:b0:45e:edc8:d440 with SMTP id
 ffacd0b85a97d-460304eb3b6mr3262043f8f.1.1780651540042; 
 Fri, 05 Jun 2026 02:25:40 -0700 (PDT)
X-Received: by 2002:adf:fcce:0:b0:45e:edc8:d440 with SMTP id
 ffacd0b85a97d-460304eb3b6mr3262001f8f.1.1780651539453; 
 Fri, 05 Jun 2026 02:25:39 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm39955766f8f.29.2026.06.05.02.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:25:38 -0700 (PDT)
Date: Fri, 5 Jun 2026 05:25:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260605051949-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKUHBiQNqvhqxr8@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 04, 2026 at 12:37:58PM +0200, Paolo Bonzini wrote:
> > Il mer 3 giu 2026, 19:54 Daniel P. Berrangé <berrange@redhat.com> ha
> > scritto:
> > 
> > > The AI policy should just
> > > make a point that we expect to be communicating with people not
> > > bots pretending to be people.
> > >
> > 
> > Yes, it's better to have that stated clearly.
> > 
> > > True but we also need a rule. The spirit is better explained elsewhere
> > > > (and also, building consensus on spirit vs. a rule are two different
> > > > things).
> > >
> > > Do we have a better elsewhere in this case ?  It is a point specifically
> > > about intent of the AI policy rule.
> > 
> > 
> > The rule in this draft says 20 lines, tests, mechanical changes and docs.
> > The spirit is what is in the commit message, basically to maximize the
> > benefit and limit the possible damage?
> 
> Putting "the spirit" in the commit message is essentially /dev/null to
> anyone reading the policy later.
> 
> > > See my reply to Peter elsewhere in the thread. I agree with your
> > > > concerns for both docs and discretion, but I had specific uses in mind
> > > > that I'd like to allow.
> > > >
> > > > For docs:
> > > > - create tutorials and/or feature documentation based on functional tests
> > >
> > > That doesn't sound too appealing to me. Reverse engineering docs or
> > > tutorials from our functional tests is exactly the kind of thing that feels
> > > likely to result in volumous text of marginal value which will have a large
> > > burden on reviewers.
> > >
> > 
> > At the same time this can be helpful for maintainers themselves? Let's also
> > look at this from the point of view of producing better output, not just
> > from that of being on the receiving end of slop. Especially for docs I have
> > a hard time imagining people sending out whole new "manuals"... The
> > bugfixes rule ironically seems the most dangerous to me from the
> > Dunning-Krueger point of view.
> > 
> > My question is: do we want disclosure for anything is created with the help
> > of LLMs, even if only small parts survive untouched? I think so, because a
> > lot more, even if edited, would still be originally from AI. But then it's
> > important to have rules allowing it and a way to track it.
> 
> IMHO need unconditional disclosure, because the use of the LLM impacts
> the license of the code. QEMU is traditionally expected to be GPLv2+
> licensed for all new code, but there's the train of thought that LLM
> code is public domain.
> If it gets human editting afterwards we can
> consider that the human edits are GPLv2+ licensed, but IMHO we still
> want to know the origins.

Wait that's a big ask.

DOC explicitly does not ask if code might be available anywhere else
under any other license. Just that contributor can contribute under GPL.
If it's public domain then the human can license is under GPL.


> 
> 
> > It would definitely be intended for merge. There's a lot of boilerplate
> > code in the Rust bindings, for example, that is voluminous but *mostly*
> > lacks creativity---the creative part basically can be described by the
> > spec/docs and should already clear the low bar required for originality,
> > even if the code is automatically generated. I included a couple examples
> > in my reply to Peter.
> 
> So we know there are examples which are probably low risk from a license
> POV, but which are massively larger than 20 lines of code. This just
> makes me more uncomfortable with the 20 line rule as the definition of
> the policy - we know that rule is wrong / undesirable from the start and
> needs this exception to make it viable.


So 20 lines or mechanical changes? what is considered mechanical will be
decided by maintainers, contributor should check with them up front.

> 
> 
> > The talk about experimenting with LLMS for larger changes emphasizes
> > > experimentation  and use of PRs in order to trigger the run of tools from
> > > their review pipeline.
> > >
> > > That doesn't explicitly say whether such "experiments" are permissible to
> > > be merged though
> > 
> > 
> > There is a part that mentions "pre-arranged, non-critical, high-quality,
> > well-tested, and well-reviewed code changes that are originally created by
> > an LLM", "to experiment with LLMs to inform future policies".
> > 
> > They mention a private channel where maintainers can discuss whether the
> > PRs pass the standards required of LLM changes. The mention of a higher
> > standard strongly suggests that they intend to accept them, otherwise why
> > would you have people do the work for nothing.
> > 
> > Likewise, they say that for CI runs no disclosure is needed while "if a PR
> > is no longer marked as clearly experimental, at that point disclosure is
> > required". The no-longer-experimental PRs fall under the previous rule, and
> > IMO this sentence also supports my reading that they are intended for
> > merging.
> > 
> > This is what I would like to have in QEMU as well, so that people are able
> > to learn. We need to trust maintainers to understand the spirit---which
> > does mean we need to write it down, though. :)
> 
> I'm mostly concerned with the likelihood of inconsistency across areas
> of QEMU if we leave it upto individual maintainers' discretion. This
> doesn't give non-regular contributors a good impression of what's
> allowed and what's not, across the codebase as a whole IMHO.
> 
> With regards,
> Daniel

Always the case in many other areas :) People are inconsistent.


> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



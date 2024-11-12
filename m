Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF6FD32D81
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAnds-00086l-Rv; Tue, 12 Nov 2024 04:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAndr-00086T-2C
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tAndp-0006Pe-FS
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731405414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=VYCxXvVEGee/6bdTWUucDkFNxtLM1q9bkTLNFfxxtrA=;
 b=OoQh5vBaJLhgprpUsiRmyMU6PMZMfbgH+kEsD8rdnGamYOnfUAgEkeWlHawRrKkjRWpFwR
 CmvRUN1KDrIdd7AgY7mUGSiUb5ye+MpfB0UA73Zps/aIYUuipOdNwLGMAInMkUxQvZwlan
 68u3vr3STjcW8gs0MIjiMf5eF26BXOI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-m7A9KocDMgiSnocb14sJpA-1; Tue, 12 Nov 2024 04:56:51 -0500
X-MC-Unique: m7A9KocDMgiSnocb14sJpA-1
X-Mimecast-MFC-AGG-ID: m7A9KocDMgiSnocb14sJpA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a99fd71e777so470354566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731405410; x=1732010210;
 h=content-transfer-encoding:subject:cc:to:autocrypt:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYCxXvVEGee/6bdTWUucDkFNxtLM1q9bkTLNFfxxtrA=;
 b=uIIekK7v0mKufRn41WlkfwH/Pz741M7XKsrLRJsHdTeudqDvPnBnBqczpR4quHe+rw
 f0Uper86QaHQ5t02gCouxjsoOKnkeeSLUTjnEaNQYOboilWsLjZ/NvRXz1nHXNcIq/Le
 JdN4cvXsMRUpgpcPfG2qrjgsjFXH/g6saXDe5XrzO7B7bT8TN64FEWqvg+tjSrolSqPJ
 UgQ8bzpHn2XhMHyfYNYPZU9y6MGShnTL4PkQntLu28nON5jYAh7s702j7FZ1a/Y7KLeS
 y9EmW1WqX1zE7cOraaZ07EW+4D3pwg3/mSqY9iyHqMXrqs0PzpvQsS8SrsVRuUCT8Z4r
 10YQ==
X-Gm-Message-State: AOJu0Yz74+HcAdnj5wfMt3DLNwGsyAwDr1ER3GUCmhry9lt86Uv8eyHw
 KwiX+Wm+hZ7/dIA5XENJ+wPZpIBrcI5U4EbV8SE7Ykfv96SMLJw7ddcO20ebO7wMXy1XQrX3xiC
 SJC3DJCE09u616e/tOZoxHBPMIpxzHNz3FF9d0VMIjIECZYgtJKgcZ86eq9LkCXDQF03g6mJjqP
 qO+a9/fyPVEnc2Yddmbi7oTbf9AN+e7V6x
X-Received: by 2002:a17:907:9288:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-a9ef0040b8amr1391226166b.61.1731405410630; 
 Tue, 12 Nov 2024 01:56:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXZ+EeOWtPVnigjXzQZNs+EV2OMcIApOSB+asMyRyrCv8GbYVbk5Jin3+P6o2Xky0JkAXUtw==
X-Received: by 2002:a17:907:9288:b0:a9a:10c9:f4b8 with SMTP id
 a640c23a62f3a-a9ef0040b8amr1391222666b.61.1731405410249; 
 Tue, 12 Nov 2024 01:56:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-175.web.vodafone.de.
 [109.42.50.175]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a18b15sm695474766b.18.2024.11.12.01.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 01:56:49 -0800 (PST)
Message-ID: <74101c41-fbc8-412e-aa8f-c330f5af36b5@redhat.com>
Date: Tue, 12 Nov 2024 10:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Subject: QEMU Code of Conduct mediation team
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


  Hi everybody!

TL;DR: As mentioned in

  https://lore.kernel.org/qemu-devel/CAFEAcA8pqjY-VKXPOe9W7J6upVhMeX8jJ=9Gmb8e64EtqHMQ_g@mail.gmail.com/

there's the idea of having a dedicated group of people that can help to 
mediate Code of Conduct related problems. If you are interested in joining 
such a group, please continue reading and get in touch with me.

Long story:

For most of the time, the QEMU project is (IMHO) a rather peaceful project, 
but in some rare times it happens that people disagree and start to use 
inappropriate wording in their communication. Sometimes this also happened 
with maintainers, too, who should normally set a good example for the 
community. We're all humans, and most of the time we're able to quickly 
settle such situations on our own (e.g. by reflecting the situation and 
providing an appropriate apology if necessary), but sometimes there are also 
situations that need additional handling. For this, the QEMU project 
introduced a Code of Conduct and a conflict resolution policy:

  https://www.qemu.org/docs/master/devel/code-of-conduct.html

  https://www.qemu.org/docs/master/devel/conflict-resolution.html

The conflict resolution policy suggests to contact the QEMU leadership 
committee in case of problems that you can't solve easily on your own. But 
since the people from the leadership committee are often very busy with 
other stuff, there were some situations where this has not worked very well 
(see also: 
https://lore.kernel.org/qemu-devel/CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com/ 
).

Because of this, at QEMU Summit we decided to introduce a separate team 
who's willing to help with handling code of conduct issues.  This covers 
mediation between parties, and if needed escalations to the remedies that 
are described in the conflict resolution policy.  I'm sending out this call 
because I'd be interested in helping and being part of the team.

The team members will be listed as primary contact persons in the conflict 
resolution document (instead of pointing the reporter to the leadership 
committee), and should be ready to help with incidents in time (meaning that 
they should e.g. respond timely during their normal working hours).
They will receive incident reports and try to mediate between the parties. 
In case of severe or unmanageable misbehavior where further remedies are 
necessary, the mediation team leadership will collaborate with the project 
leadership team (to see what needs to be done according to the conflict 
resolution document).

So if you like the QEMU community and want to help in keeping it a pleasant 
place for everybody, please consider joining the team! It would also be 
especially great to have people from different time zones and different 
groups in the team, so please don't be shy if you've got a little bit of 
interest in this topic! And in case you've got some questions first, please 
also feel free to contact me, either on-list here or also off-list.

  I'm looking forward to hearing from you,
   Thomas



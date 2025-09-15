Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8EECAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 06:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy2wr-00084I-MH; Mon, 15 Sep 2025 02:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uy2wo-00083z-Fc
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uy2wi-0004mD-QJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 02:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757918651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52J4XT6nxlSlpvckviPS0k5KMSIjaF/9aULPTAf6VAM=;
 b=hrVeiqSXSPbjz0izk292UMaicrt4/wUzW4Bz/JQLwEcc/mp9/9DSMC74ZzINWGSN9YylOp
 BMnIkQSwLTMfuHYHvpLZPHpqax4rmQdCvv+zYJUkMeGPfLeaphGM6z4TB+PRESciHm89l/
 56QUFsBcVkaJTAwFTXHGdhJzKkoaH3o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-PP9qLJDuMfaVbW48v6A9Pg-1; Mon,
 15 Sep 2025 02:44:07 -0400
X-MC-Unique: PP9qLJDuMfaVbW48v6A9Pg-1
X-Mimecast-MFC-AGG-ID: PP9qLJDuMfaVbW48v6A9Pg_1757918646
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B29C419774FA; Mon, 15 Sep 2025 06:44:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 239EC300021A; Mon, 15 Sep 2025 06:44:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B420921E6A27; Mon, 15 Sep 2025 08:44:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com,  berrange@redhat.com,  richard.henderson@linaro.org,
 david@redhat.com,  jrossi@linux.ibm.com,  qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org,  walling@linux.ibm.com,  jjherne@linux.ibm.com,
 pasic@linux.ibm.com,  borntraeger@linux.ibm.com,  farman@linux.ibm.com,
 mjrosato@linux.ibm.com,  iii@linux.ibm.com,  eblake@redhat.com,
 alifm@linux.ibm.com
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
In-Reply-To: <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com> (Zhuoying
 Cai's message of "Fri, 12 Sep 2025 14:05:49 -0400")
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com>
 <87v7lpjvsw.fsf@pond.sub.org>
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
 <87wm64b29p.fsf@pond.sub.org>
 <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com>
Date: Mon, 15 Sep 2025 08:44:02 +0200
Message-ID: <87tt14z03x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Zhuoying Cai <zycai@linux.ibm.com> writes:

> On 9/12/25 2:42 AM, Markus Armbruster wrote:
>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>> 
>>> Thanks for the feedback.
>>>
>>> On 9/11/25 3:24 AM, Markus Armbruster wrote:
>>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>>
>>>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>>>> machine. This allows users to specify one or more certificate file paths
>>>>> or directories to be used during secure boot.
>>>>>
>>>>> Each entry is specified using the syntax:
>>>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>>>
>>>>> Multiple paths can be specify using array properties:
>>>>> 	boot-certs.0.path=/path/to/cert.pem,
>>>>> 	boot-certs.1.path=/path/to/cert-dir,
>>>>> 	boot-certs.2.path=/path/to/another-dir...
>>>>>
>>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>>>> ---
>>>>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>>>>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>>>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>>>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
>>>>>  qemu-options.hx                    |  6 +++++-
>>>>>  5 files changed, 81 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 docs/system/s390x/secure-ipl.rst
>>>>>
>>>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>>>> new file mode 100644
>>>>> index 0000000000..9b3fd25cc4
>>>>> --- /dev/null
>>>>> +++ b/docs/system/s390x/secure-ipl.rst
>>>>> @@ -0,0 +1,20 @@
>>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +
>>>>> +Secure IPL Command Line Options
>>>>> +===============================
>>>>> +
>>>>> +New parameters have been introduced to s390-ccw-virtio machine type option
>>>>> +to support secure IPL. These parameters allow users to provide certificates
>>>>> +and enable secure IPL directly via the command line.
>>>>
>>>> All too soon these parameters will no longer be new.  Consider something
>>>> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
>>>> it, you need to provide certificates."
>>>>
>>>>> +
>>>>> +Providing Certificates
>>>>> +----------------------
>>>>> +
>>>>> +The certificate store can be populated by supplying a list of certificate file
>>>>> +paths or directories on the command-line:
>>>>
>>>> File is clear enough (use the certificate found in the file).  What does
>>>> directory do?
>>>
>>> A directory contains a list of certificate files, and allowing both
>>> files and directories could make the CLI more flexible.
>> 
>> I figure when @path names a file, it's an error when the file doesn't
>> contain a valid cetificate.
>> 
>> What is @path names a directory, and one of the directory's files
>> doesn't contain a valid certificate?
>> 
>> Can a single file contain multiple certificates?
>
> A certificate file path is expected to contain exactly one certificate.
>
> Certificates provided through the CLI, whether as individual files or
> within a directory, are validated before use. If a certificate is
> invalid (e.g., unsupported format), it will be skipped and not added to
> the S390 certificate store.

Hmm.  What exactly happens when I configure a certificate file like

    -machine s390-ccw-virtio,boot-certs.0.path=/dev/null

or some other file that doesn't contain a valud certificate?  Is it
silently ignored, or is it an error?

> When iterating through the provided paths, the program will terminate on
> fatal configuration errors, such as when a specified path is neither a
> file nor a directory.

[...]



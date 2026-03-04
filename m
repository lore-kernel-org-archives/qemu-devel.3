Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CC5EDEC1E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgot-0001OT-NK; Wed, 04 Mar 2026 02:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxgoq-0001O1-9r
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:38:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxgom-0007s0-H5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772609931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cl4WrG2F/geB5QN0fMF69n9RNAObVArhKxorRCZFJMg=;
 b=Kbpdzrf9itSLzzT+JNzJs3yi9P247At7dpZCnnIr2AYg4iawr3gV2a08P75676jfyZBDCw
 AHlyfrTjv8MYiqZJzSLD1YQAGJm6VBJ013yjSJ667v+ZUgjRNXA5EzrUysE/eHV82gl9n8
 IKg3D13lug8j/zpXT/c4rPICkt2m8jQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-6amolIZhNyy2Z_A1sSnMJg-1; Wed,
 04 Mar 2026 02:38:47 -0500
X-MC-Unique: 6amolIZhNyy2Z_A1sSnMJg-1
X-Mimecast-MFC-AGG-ID: 6amolIZhNyy2Z_A1sSnMJg_1772609926
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0D07195608D; Wed,  4 Mar 2026 07:38:45 +0000 (UTC)
Received: from [10.45.224.194] (unknown [10.45.224.194])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51528195608E; Wed,  4 Mar 2026 07:38:42 +0000 (UTC)
Message-ID: <8b2855dc-44eb-417f-8a18-f40b1036637a@redhat.com>
Date: Wed, 4 Mar 2026 08:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] configure: Use clang for sanitizer builds or
 disable Werror
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260303012054.484837-1-yodel.eldar@yodel.dev>
 <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <f999293f-c424-497a-8bca-2634bcd68108@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 04/03/2026 02.08, Yodel Eldar wrote:
> +Daniel (thanks for your comments)
> 
> On 02/03/2026 19:20, Yodel Eldar wrote:
>> From: Yodel Eldar <yodel.eldar@yodel.dev>
>>
>> Builds with --enable-{asan,tsan,safe-stack} fail under GCC, so use
>> clang if available, otherwise disable the treatment of warnings as
>> errors.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>> Hi,
>>
>> The previous version only disabled Werror whenever `--skip-meson` wasn't
>> used and the build occurred in a git repo, but this change should
>> probably apply to all types of builds. So, let's use meson_option_add
>> to globally disable Werror instead; IIUC (and according to my testing),
>> this will override the value in config-meson.cross.new.
>>
>> I'm still not sure if we should be disabling Werror for ubsan, even
>> though it's not currently breaking builds with GCC; please let me know
>> what you think.
>>
>> Special thanks to Peter for looking into the cause of the reports around
>> this, for sharing the findings, and suggesting approaches to resolve it.
>> I couldn't pick one over the other, so I went with using clang when
>> available with Werror disable as a fallback; please let me know if you
>> think this is an XOR kind of policy decision.
>>
>> Link to RFCv1:
>> https://lore.kernel.org/qemu-devel/20260302210039.261325-1- 
>> yodel.eldar@yodel.dev/
>>
>> Link to mentioned discussion:
>> https://lore.kernel.org/qemu-devel/ 
>> CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
>>
>> v2:
>> - Fix misnomer in commit message
>> - Simplify condition by using the same variable for all sanitizers
>> - Use meson_option_add to disable Werror
>>
>> Thanks,
>> Yodel
>> ---
>>   configure | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 5e114acea2..e457e8a17d 100755
>> --- a/configure
>> +++ b/configure
>> @@ -762,6 +762,12 @@ for opt do
>>     ;;
>>     --wasm64-32bit-address-limit)
>>     ;;
>> +  --enable-asan) use_sanitizer="yes"
>> +  ;;
>> +  --enable-tsan) use_sanitizer="yes"
>> +  ;;
>> +  --enable-safe-stack) use_sanitizer="yes"
>> +  ;;
>>     # everything else has the same name in configure and meson
>>     --*) meson_option_parse "$opt" "$optarg"
>>     ;;
>> @@ -771,6 +777,18 @@ for opt do
>>     esac
>>   done
>> +if test "$use_sanitizer" = "yes"; then
>> +    if has clang; then
>> +        echo "Sanitizer requested: setting compiler suite to clang"
>> +        cc=clang
>> +        cxx=clang++
>> +        host_cc=clang
>> +    else
>> +        echo "Sanitizer requested: disabling Werror for non-clang compilers"
>> +        meson_option_add -Dwerror=false
>> +    fi
>> +fi
>> +
>>   if ! test -e "$source_path/.git"
>>   then
>>       git_submodules_action="validate"
> 
> We could treat the rtl8139 as a one-off by carving out the
> offending code with a GCC pragma or finagling GCC into cooperation
> by substituting eth_payload_data with the expression assigned to it
> (thank you, Thomas and Daniel, respectively); indeed, AFAICT the
> rtl8139 is currently the only code that triggers the GCC bug
> (and is overdue for a refactor/cleanup), so it's tempting to go with
> either of these helpful suggestions; *however*, until the GCC team
> fixes their buggy pairing between sanitizer and -Werror
> (a pairing that they themselves disavow [1]), IMHO there's a
> significant risk of recurrence if we went with either option, and
> it's not clear to me whether reviewers will be able easily spot the
> next one before it's too late (post-acceptance).
> 
> That said, I fully share Daniel's concerns about "overriding the
> user's choice of compiler"; so, what if we instead moved the
> sanitizer check into the existing "Preferred compiler" section
> in configure, such that we only set cc=clang when the user hasn't
> explicitly specified CC/CXX (diff below)? Note: there's already
> precedent for this with the Obj-C compiler [2].
> 
> I'm definitely onboard with Daniel's warning message in meson whenever
> the user: 1) explicitly opts for gcc/g++, 2) enables sanitizers, and 3)
> -Werror is enabled. At the risk of overengineering, though, what if we
> made it an error message instead, and gave users an escape hatch like
> `--force-werror-sanitizers` (name TBD)? I can see that being too much,
> but it may prevent some grief if they missed the warning, and the build
> breaks several minutes later. WDYT? It's not included in the diff below,
> but I'll gladly add it to v3 if there's interest; if not, I'll go with
> the warning message as suggested.

I think I would rather avoid another switch like --force-werror-sanitizers 
and making it a hard error instead of a warning. Think of the point in time 
when GCC fixed their bug - if someone then wants to compile QEMU with that 
new GCC, this becomes rather obstructive.

Alternative idea: What about adding -Wno-stringop-overflow to the CFLAGS 
when we detect the problematic situation (GCC + sanitizers + -Werror)? Then 
the build could also continue with GCC without running into the problem.

  Thomas



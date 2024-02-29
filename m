Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7A4C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgTB-0000WL-AQ; Thu, 29 Feb 2024 08:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgT5-0000UQ-8N
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfgT3-0006vm-Pd
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709213336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnQPnqAt3BZw9D26tvLnsVZaWFXrJYHmtq+zViDCJHQ=;
 b=f9TMvPkaKSAisdLV+DSEL+ej0hAnKGdvSRnhLU+RcmgTNKhQdGo1bHChs8D64m1wwrqOHc
 RZPfXoI1M+DWHf8gB3B4Ws7g9r7vtny2bCRz+ybhTxGseWT07zqb+/ftC4A4ruxZ4PRee/
 cJ1ZaCk+nlBKONmVgiVvsHhTxCIp8vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-bosJRe1EPT6tKL6wtdY0dw-1; Thu, 29 Feb 2024 08:28:53 -0500
X-MC-Unique: bosJRe1EPT6tKL6wtdY0dw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A04683106F;
 Thu, 29 Feb 2024 13:28:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244391BDB1;
 Thu, 29 Feb 2024 13:28:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16D0621E66D0; Thu, 29 Feb 2024 14:28:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ani Sinha <anisinha@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,
 qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Claudio
 Fontana <cfontana@suse.de>,  Gerd Hoffmann <kraxel@redhat.com>,  Isaku
 Yamahata <isaku.yamahata@gmail.com>,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 49/65] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
In-Reply-To: <8a2c760d-6310-42eb-b632-5f67b12e2149@intel.com> (Xiaoyao Li's
 message of "Thu, 29 Feb 2024 18:54:48 +0800")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-50-xiaoyao.li@intel.com>
 <87a5nj1x4l.fsf@pond.sub.org>
 <8a2c760d-6310-42eb-b632-5f67b12e2149@intel.com>
Date: Thu, 29 Feb 2024 14:28:51 +0100
Message-ID: <87wmqnwga4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 2/29/2024 4:40 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Add property "quote-generation-socket" to tdx-guest, which is a property
>>> of type SocketAddress to specify Quote Generation Service(QGS).
>>>
>>> On request of GetQuote, it connects to the QGS socket, read request
>>> data from shared guest memory, send the request data to the QGS,
>>> and store the response into shared guest memory, at last notify
>>> TD guest by interrupt.
>>>
>>> command line example:
>>>    qemu-system-x86_64 \
>>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"1","port":"1234"}}' \
>>>      -machine confidential-guest-support=tdx0
>>>
>>> Note, above example uses vsock type socket because the QGS we used
>>> implements the vsock socket. It can be other types, like UNIX socket,
>>> which depends on the implementation of QGS.
>>>
>>> To avoid no response from QGS server, setup a timer for the transaction.
>>> If timeout, make it an error and interrupt guest. Define the threshold of
>>> time to 30s at present, maybe change to other value if not appropriate.
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> [...]
>> 
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index cac875349a3a..7b26b0a0d3aa 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -917,13 +917,19 @@
>>>  #     (base64 encoded SHA384 digest). (A default value 0 of SHA384 is
>>>  #     used when absent).
>>>  #
>>> +# @quote-generation-socket: socket address for Quote Generation
>>> +#     Service (QGS).  QGS is a daemon running on the host.  User in
>>> +#     TD guest cannot get TD quoting for attestation if QGS is not
>>> +#     provided.  So admin should always provide it.
>>
>> This makes me wonder why it's optional.  Can you describe a use case for
>> *not* specifying @quote-generation-socket?
>
> Maybe at last when all the TDX support lands on all the components, attestation will become a must for a TD guest to be usable.
>
> However, at least for today, booting and running a TD guest don't require attestation. So not provide it, doesn't affect anything excepting cannot get a Quote.

Maybe

  # @quote-generation-socket: Socket address for Quote Generation
  #     Service (QGS).  QGS is a daemon running on the host.  Without
  #     it, the guest will not be able to get a TD quote for
  #     attestation.

[...]



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31551C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5AWS-00066c-Aa; Thu, 09 May 2024 16:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AWQ-00066T-80
 for qemu-devel@nongnu.org; Thu, 09 May 2024 16:37:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s5AWN-0004Ui-Te
 for qemu-devel@nongnu.org; Thu, 09 May 2024 16:37:46 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BEB434E6106;
 Thu, 09 May 2024 22:37:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id uU64Vjxk-kck; Thu,  9 May 2024 22:37:39 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7433B4E600E; Thu, 09 May 2024 22:37:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 71646746E3B;
 Thu, 09 May 2024 22:37:39 +0200 (CEST)
Date: Thu, 9 May 2024 22:37:39 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Cord Amfmgm <dmamfmgm@gmail.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
In-Reply-To: <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
Message-ID: <6fab2d56-84c4-15fa-bcaf-b08f2c8210aa@eik.bme.hu>
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
 <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
 <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-550298523-1715287059=:42272"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-550298523-1715287059=:42272
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 9 May 2024, Cord Amfmgm wrote:
> On Thu, May 9, 2024 at 12:48 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
>> On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>>> On Wed, May 8, 2024 at 3:45 AM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> Your Signed-off-by line does not match the From: line ... could you
>> please
>>>> fix this? (see
>>>>
>> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
>>>> , too)
>>>
>>>
>>> I'll submit the new patch request with my pseudonym in the From: and
>> Signed-off-by: lines, per your request. Doesn't matter to me. However, this
>> arises simply because I don't give gmail my real name -
>> https://en.wikipedia.org/wiki/Nymwars
>>
>> I'm confused now. Of the two names you've used in this
>> patch (Cord Amfmgm and David Hubbard), are they both
>> pseudonyms, or is one a pseudonym and one your real name?
>>
>>
> Hi Peter,
>
> I am attempting to submit a small patch. For context, I'm getting broader
> attention now because apparently OHCI is one of the less used components of
> qemu and maybe the review process was taking a while. That's relevant
> because I wasn't able to get prompt feedback and am now choosing what
> appears to be the most expeditious approach -- all I want is to get this
> patch done and be out of your hair. If Thomas Huth wants me to use a
> consistent name, have I not complied? Are you asking out of curiosity or is
> there a valid reason why I should answer your question in order to get the
> patch submitted? Would you like to have a friendly chat over virtual coffee
> sometime (but off-list)?

See here:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line
and also the document linked from there:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297

As for getting the patch reviewed, it may be difficult as the USB 
maintainer is practically absent and has no time for QEMU for a while and 
as OHCI as you said is not odten used there aren't many people who could 
review it. Getting at least the formal stuff out of the way may help 
though to get somebody to try to review the patch.

Regards,
BALATON Zoltan
--3866299591-550298523-1715287059=:42272--

